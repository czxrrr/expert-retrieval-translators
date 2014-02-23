import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import ciir.umass.edu.eval.Evaluator;
import ciir.umass.edu.features.Normalizer;
import ciir.umass.edu.features.SumNormalizor;
import ciir.umass.edu.learning.RANKER_TYPE;
import ciir.umass.edu.learning.RankerFactory;
import ciir.umass.edu.metric.ERRScorer;
import ciir.umass.edu.metric.MetricScorer;
import ciir.umass.edu.metric.MetricScorerFactory;
import ciir.umass.edu.utilities.MyThreadPool;
import ciir.umass.edu.utilities.SimpleMath;


public class runit {

	public static void main(String[] args) throws IOException {
		randomClassifier();
			    
	    //saveFile(loadFile(), 5);
	}
	
	private static StringBuilder loadFile() throws IOException
	{
		BufferedReader br = new BufferedReader(new FileReader("l2r\\data\\train_standardized.letor"));
		StringBuilder sb = new StringBuilder();
		
	    try {
	    	String line1 = br.readLine();
	        String line2 = br.readLine();
	        String line3 = br.readLine();
        
	        while ((line1 != null) && (line2 != null) && (line3 != null)) {
	        	int[] rndRank = getRandomRank();
		        
		        line1 = rndRank[0] + line1.substring(1);
		        line2 = rndRank[1] + line2.substring(1);
		        line3 = rndRank[2] + line3.substring(1);

		        sb.append(line1);
	            sb.append(System.lineSeparator());
	            sb.append(line2);
	            sb.append(System.lineSeparator());
	            sb.append(line3);
	            sb.append(System.lineSeparator());
	            
	            line1 = br.readLine();
		        line2 = br.readLine();
		        line3 = br.readLine();
	        }
	    } finally {
	        br.close();
	    }
	    return sb;
	}
	
	private static int[] getRandomRank()
	{
		int[] res = new int[3];
		Random random = new Random();
		res[0] = random.nextInt(3) + 1;
		int rnd = random.nextInt(2) + 1;
		res[1] = (res[0] + rnd) % 4;
		if (res[1] == 0)
			res[1] = 1;
		for (int i = 1; i <= 3; i++)
		{
			if ((res[0] != i) && (res[1] != i))
			{
				res[2] = i;
				break;
			}
		}
		return res;
	}

	private static void saveFile(StringBuilder sb, int idx)
	{
		try {
	    	 
			String content = sb.toString();
 
			File file = new File("l2r\\data\\train_standardized_random" + idx + ".letor");
 
			// if file doesnt exists, then create it
			if (!file.exists()) {
				file.createNewFile();
			}
 
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(content);
			bw.close();
 
			System.out.println("Done");
 
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//main settings
	public static boolean mustHaveRelDoc = false;
	public static boolean useSparseRepresentation = false;
	public static boolean normalize = false;
	public static Normalizer nml = new SumNormalizor();
	public static String modelFile = "";
 	
 	public static String qrelFile = "";//measure such as NDCG and MAP requires "complete" judgment.
 	//The relevance labels attached to our samples might be only a subset of the entire relevance judgment set.
 	//If we're working on datasets like Letor/Web10K or Yahoo! LTR, we can totally ignore this parameter.
 	//However, if we sample top-K documents from baseline run (e.g. query-likelihood) to create training data for TREC collections,
 	//there's a high chance some relevant document (the in qrel file TREC provides) does not appear in our top-K list -- thus the calculation of
 	//MAP and NDCG is no longer precise. If so, specify that "external" relevance judgment here (via the -qrel cmd parameter)
 	
 	//tmp settings, for personal use
 	public static String newFeatureFile = "";
 	public static boolean keepOrigFeatures = false;
 	public static int topNew = 2000;

 	protected RankerFactory rFact = new RankerFactory();
	protected MetricScorerFactory mFact = new MetricScorerFactory();
	
	protected MetricScorer trainScorer = null;
	protected MetricScorer testScorer = null;
	protected RANKER_TYPE type = RANKER_TYPE.MART;

	private static void randomClassifier()
	{
		String[] rType = new String[]{"MART", "RankNet", "RankBoost", "AdaRank", "Coordinate Ascent", "LambdaRank", "LambdaMART", "ListNet", "Random Forests", "Linear Regression", "Random Ranker"};
		RANKER_TYPE[] rType2 = new RANKER_TYPE[]{RANKER_TYPE.MART, RANKER_TYPE.RANKNET, RANKER_TYPE.RANKBOOST, RANKER_TYPE.ADARANK, RANKER_TYPE.COOR_ASCENT, RANKER_TYPE.LAMBDARANK, RANKER_TYPE.LAMBDAMART, RANKER_TYPE.LISTNET, RANKER_TYPE.RANDOM_FOREST, RANKER_TYPE.LINEAR_REGRESSION, RANKER_TYPE.RANDOM_RANK};
		
		String trainFile = "";
		String featureDescriptionFile = "";
		float ttSplit = 0;//train-test split
		float tvSplit = 0;//train-validation split
		int foldCV = -1;
		String validationFile = "";
		String testFile = "";
		List<String> testFiles = new ArrayList<String>();
		int rankerType = 9;
		String trainMetric = "ERR@10";
		String testMetric = "";
		Evaluator.normalize = false;
		String savedModelFile = "";
		List<String> savedModelFiles = new ArrayList<String>();
		String kcvModelDir = "";
		String kcvModelFile = "";
		String rankFile = "";
		String prpFile = "";
		
		int nThread = -1; // nThread = #cpu-cores
		//for my personal use
		String indriRankingFile = "";
		String scoreFile = "";
		trainFile = "C:\\Users\\Navid\\Documents\\GitHub\\expert-retrieval-translators\\l2r\\data\\train_standardized.letor.random5";
		rankerType = 10;
		trainMetric = "NDCG@3";
		testMetric = "NDCG@3";
		foldCV = 5;
		
		kcvModelDir = "C:\\Users\\Navid\\Documents\\GitHub\\expert-retrieval-translators\\l2r\\data\\models\\";
		kcvModelFile = "ca";
		
		if(nThread == -1)
			nThread = Runtime.getRuntime().availableProcessors();
		MyThreadPool.init(nThread);
		
		System.out.println("");
		//System.out.println((keepOrigFeatures)?"Keep orig. features":"Discard orig. features");
		System.out.println("[+] General Parameters:");
		Evaluator e = new Evaluator(rType2[rankerType], trainMetric, testMetric);
		if(trainFile.compareTo("")!=0)
		{
			System.out.println("Training data:\t" + trainFile);
			
			//print out parameter settings
			if(foldCV != -1)
			{
				System.out.println("Cross validation: " + foldCV + " folds.");
				if(tvSplit > 0)
					System.out.println("Train-Validation split: " + tvSplit);
			}

			System.out.println("Feature vector representation: " + ((useSparseRepresentation)?"Sparse":"Dense") + ".");
			System.out.println("Ranking method:\t" + rType[rankerType]);
			if(featureDescriptionFile.compareTo("")!=0)
				System.out.println("Feature description file:\t" + featureDescriptionFile);
			else
				System.out.println("Feature description file:\tUnspecified. All features will be used.");
			System.out.println("Train metric:\t" + trainMetric);
			System.out.println("Test metric:\t" + testMetric);
			if(trainMetric.toUpperCase().startsWith("ERR") || testMetric.toUpperCase().startsWith("ERR"))
				System.out.println("Highest relevance label (to compute ERR): " + (int)SimpleMath.logBase2(ERRScorer.MAX));
			if(qrelFile.compareTo("") != 0)
				System.out.println("TREC-format relevance judgment (only affects MAP and NDCG scores): " + qrelFile);
			System.out.println("Feature normalization: " + ((Evaluator.normalize)?Evaluator.nml.name():"No"));
			if(kcvModelDir.compareTo("")!=0)
				System.out.println("Models directory: " + kcvModelDir);
			if(kcvModelFile.compareTo("")!=0)
				System.out.println("Models' name: " + kcvModelFile);				
			if(modelFile.compareTo("")!=0)
				System.out.println("Model file: " + modelFile);
			//System.out.println("#threads:\t" + nThread);
			
			System.out.println("");
			System.out.println("[+] " + rType[rankerType] + "'s Parameters:");
			RankerFactory rf = new RankerFactory();
			
			rf.createRanker(rType2[rankerType]).printParameters();
			System.out.println("");
			
			//starting to do some work
			if(foldCV != -1)
			{
				if(kcvModelDir.compareTo("") != 0 && kcvModelFile.compareTo("") == 0)
					kcvModelFile = "default";
				e.evaluate(trainFile, featureDescriptionFile, foldCV, tvSplit, kcvModelDir, kcvModelFile);//models won't be saved if kcvModelDir="" 
			}
		}
		MyThreadPool.getInstance().shutdown();
	}
}

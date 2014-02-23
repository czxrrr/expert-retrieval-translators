/*===============================================================================
 * Copyright (c) 2010-2012 University of Massachusetts.  All Rights Reserved.
 *
 * Use of the RankLib package is subject to the terms of the software license set 
 * forth in the LICENSE file included with this software, and also available at
 * http://people.cs.umass.edu/~vdang/ranklib_license.html
 *===============================================================================
 */

package ciir.umass.edu.learning;

import java.util.List;
import java.util.Random;

import ciir.umass.edu.metric.MetricScorer;

public class RandomRank extends Ranker {

	public RandomRank()
	{		
	}
	public RandomRank(List<RankList> samples, int[] features, MetricScorer scorer)
	{
		super(samples, features, scorer);
	}
	public void init()
	{
		PRINTLN("Initializing... [Done]");
	}
	public void learn()
	{
		PRINTLN("--------------------------------");
		PRINTLN("Training starts...");
		
		PRINTLN("---------------------------------");
		PRINTLN("Finished sucessfully.");
	}
	public double eval(DataPoint p)
	{
		Random r = new Random();
		return r.nextDouble();
	}
	public Ranker clone()
	{
		return new RandomRank();
	}
	public String toString()
	{
		return "";
	}
	public String model()
	{
		return "";
	}
	public void load(String fn)
	{
		
	}
	public void printParameters()
	{
		PRINTLN("NO PARAM");
	}
	public String name()
	{
		return "Random Rank";
	}
}

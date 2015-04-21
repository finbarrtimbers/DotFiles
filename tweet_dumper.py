#!/usr/bin/env python
# encoding: utf-8

import sys
import tweepy #https://github.com/tweepy/tweepy
import csv
import operator
import datetime

#Twitter API credentials
consumer_key = "L94bSgFDB8rTRU02z3lTbQ"
consumer_secret = "nMSOybEll5neWMPh3Vxi1JvJQumZy3gFSgkSjwbuRc"
access_key = "331872736-0lNPI6igqymUQR5ttyaSKJf7J3n6U8dBGPv1ilGD"
access_secret = "tHmMHB8sy2ZzIo6bdyptfJXnbe8KIijGfPIdseLZj3U2P"

def date_filter(tweet, start_day, end_day):
        tweet_day = [int(number) for number in tweet[1].split(" ")[0].split("-")]
        booleans = [start_day[i] <= tweet_day[i] and tweet_day[i] <= end_day[i] for i in range(3)]
        return all(booleans)

def print_for(x): 
        for item in x:
                print item
        
def reconcile(new_tweets, old_tweets):
        # BROKEN
        # TODO: fix
        # convert lists into sets so we can use set operations
        new_tweets_dict = {tweet[0]: tweet for tweet in new_tweets}
        old_tweets_dict = {tweet[0]: tweet for tweet in old_tweets}
#        print_for(new_tweets_dict.items())
        all_tweets_dict = dict(new_tweets_dict.items() + old_tweets_dict.items())
#        print_for(all_tweets_dict.items())
        reconciled_tweets = [tweet for tweet in all_tweets_dict]
        print reconciled_tweets
        sorted_reconciled_tweets = reconciled_tweets.sort(key=operator.itemgetter(1))
        return sorted_reconciled_tweets

def get_new_tweets(screen_name):
        # assumes that a user 
        #authorize twitter, initialize tweepy
        auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
        auth.set_access_token(access_key, access_secret)
        api = tweepy.API(auth)
                
        #make initial request for most recent tweets (200 is the maximum allowed count)
        alltweets = api.user_timeline(screen_name = screen_name,count=200)
	outtweets = [[tweet.id_str, tweet.created_at, tweet.text.encode("utf-8")]
                     for tweet in alltweets]
        return outtweets
        
def get_all_tweets(screen_name):
	#Twitter only allows access to a users most recent 3240 tweets with this method
	
	#authorize twitter, initialize tweepy
	auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
	auth.set_access_token(access_key, access_secret)
	api = tweepy.API(auth)
	
	#initialize a list to hold all the tweepy Tweets
	alltweets = []	
	
	#make initial request for most recent tweets (200 is the maximum allowed count)
	new_tweets = api.user_timeline(screen_name = screen_name,count=200)
	
	#save most recent tweets
	alltweets.extend(new_tweets)
	
	#save the id of the oldest tweet less one
	oldest = alltweets[-1].id - 1
	
	#keep grabbing tweets until there are no tweets left to grab
	while len(new_tweets) > 0:
                print "getting tweets from %s" %(screen_name)
		print "getting tweets before %s" % (oldest)
		
		#all subsequent requests use the max_id param to prevent duplicates
		new_tweets = api.user_timeline(screen_name = screen_name,count=200,max_id=oldest)
		
		#save most recent tweets
		alltweets.extend(new_tweets)
		
		#update the id of the oldest tweet less one
		oldest = alltweets[-1].id - 1
		
		print "...%s tweets downloaded so far" % (len(alltweets))

	#transform the tweepy tweets into a 2D array that will populate the csv	
	outtweets = [[tweet.id_str, tweet.created_at, tweet.text.encode("utf-8")]
                     for tweet in alltweets]
        return outtweets

def main(screen_name):
	all_tweets = get_all_tweets(screen_name)
        current_date = str(datetime.datetime.now().strftime("%Y-%m-%d"))
        with open(screen_name + '_tweets.csv', 'w') as csvfile:                
                csvfile.write(', '.join(["id","created_at","text"]))
                for tweet in all_tweets:
                        tweet_id, tweet_date, text = tweet[0], str(tweet[1]), tweet[2]
                        string = ', '.join([tweet_id, tweet_date, '"' + text + '"'])
                        string += '\n'
                        csvfile.write(string)

if __name__ == '__main__':
        #pass in the username of the account you want to download
        for screen_name in sys.argv[1:]:
                main(screen_name)
                

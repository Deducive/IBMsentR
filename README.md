# IBMsentR

## Simple R functions for analysing sentiment with IBM Watson

### Overview
Like other packages we've created, we're choosing simplicity over wide functionality. There are two functions at present:

1. `ibm_sent`
Simply returns sentiment back from a text string. Creds needed are simple username and password held in the local R environment.

2. `ibm_tone`
Detects tones within the submitted string / sentence. The number of tones can vary depending upon the sentence / string submitted.

### Pre-requisites
You'll need an IBM Watson account with a username and password for both sentiment and tone - they will be different.

### Usage
You use the function to send text to IBM Watson. A simple one-row tibble (data frame) will be returned with the results for both.
Depending on the length of the sentence, more than one text keyword value may be returned for sentiment. Each pair of values (text keyword & relevance score) is assigned into new numbered columns. Thus the number of columns may be irregular when binding rows from each result.

This is also the case for tone - many tones may be detected - the returned data frame will contain all as numbered columns.

***

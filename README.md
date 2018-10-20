# IBMsentR

## Simple R functions for analysing sentiment with IBM Watson

### Overview
Like other packages we've created, we're choosing simplicity over wide functionality. There's one function at present:

`IBMsentR`
... which simply returns sentiment back from a text string. Creds needed are simple username and password held in the local R environment.

### Pre-requisites
You'll need an IBM Watson account with a username and password

### Usage
You use the function to send text to IBM Watson. A simple one-row tibble (data frame) will be returned with the results.
Depending on the length of the sentence, more than one text keyword value may be returned. Each pair of values (text keyword & relevance score) is assigned into new numbered columns. Thus the number of columns may be irregular when binding rows from each result.

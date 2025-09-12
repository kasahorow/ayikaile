# multi training

In this example, we train models per agents.
We will have 69 agents, each agent will pronunce around 60 words, and for each word we can have between 01 and 02 pronunciations.

### Implementation

*Note: We won't talk about the data preparation here.*

For each agent to have a trained model on ayikaile, we will need an ayikaile membership per agent.

To manage agent credentials via our script, we manually created a [credential file](agent_credentials).

With the agent credentials, we will start the training by uploading the dataset (word by word).


### Disclaimer

This script has been written to use the [YembaEGRA](https://data.mendeley.com/datasets/74p9d5frg3/2) dataset. Each speaker will represent an agent for our usecase.

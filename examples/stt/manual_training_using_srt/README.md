# training using an srt file

In this example, we will manually train the model using a SubRip Subtitle file (SRT) and his respective audio.
The audio used here has a duration of 15s.

### Implementation

We will split the audio in segments based on his SRT file.
For each segment, we will have his subtitle representation.
At the end, each segment will be submitted for training.

### Structure

If you have a similar usecase: train a model using a SRT file and his audio, you should prepare the 03 scripts.

- audio splitter script: to split the audio in segments based on his SRT file.
- data training script: to train the model at ayikaile
- data validation script: to test if the trained models are working as expected

### Important to know

- For the ayikaile model, it's better to have an audio segment between 1.0s and 1.5s.

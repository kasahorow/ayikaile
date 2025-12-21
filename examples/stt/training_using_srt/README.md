# training using an srt file

In this example, we will train the model using a SubRip Subtitle file (SRT) and his respective audio.
The audio used here has a duration of 15s.

### Structure

If you have a similar usecase: train a model using a SRT file and his audio, you should prepare the 03 scripts.

- data training script: to train the model at ayikaile
- data validation script: to test if the trained models are working as expected

### Important to know

- For the ayikaile model, it's better to provide an SRT file with segments between 1.0s and 1.5s.

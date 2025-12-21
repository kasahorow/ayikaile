# Getting started with AYIKAILE: Multilingual at Work Support by kasahorow

This documentation is for developers looking to integrate the AYIKAILE: Multilingual at Work keyword detection API available at https://ayikaile.kasahorow.com/docs.

### Example scripts

The example scripts for auth, training and prediction are available [here](.).

### Authentification

**Generate an API access token** -> */api/v1/token*

- Go at https://ayikaile.kasahorow.com/docs and click on the "Authorize" button.
- Use your access code as follows.

```
username=<your_email>
password=<access_code>
```

- The generated token will allow you to use the API for a limited period of time (currently 01 day).

You can do it in providing your kasahorow access code as follows.

**Get a subscription id** -> */api/v1/subscriptions/*

You can get a subscription id from your available subscriptions.
If you don't have, you can buy it at [ayikaile.kasahorow.com](https://ayikaile.kasahorow.com)

### Training and usage of the Speech to Text

To train and use a speech to text model, you will have to specify the subscription id as agent id.

**Training of the model** -> */api/v1/train*

- Provide a textual representation (ascii prefered) of the word that you want the model to be able to recognize.
- Provide a minimun of 03 audio pronunciations per words (by example 03 audio pronunciations for 'hello', 03 audio pronunciations for 'hi', etc.).
- Make sure to train at least 02 words, otherwise, the model will be unusable.

*NB: Each ayikaile subscriber has a workspace to train and use his own STT model.*

**Test the model** -> */api/v1/predict*

After train the model with at least 02 words, you can test it in sending an audio file.

### License

This documentation is under the MIT license.

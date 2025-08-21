# Getting started with AYIKAILE: Multilingual at Work Support by kasahorow

This documentation is for developers looking to integrate the AYIKAILE: Multilingual at Work keyword detection API available at https://ayikaile.kasahorow.com/docs.


### Prerequisites

- Buy a support package at https://ayikaile.kasahorow.com.

### Example scripts

The example scripts for auth, training and prediction are available in the [`examples`](examples) folder.

### Authentification

**Get your access code**

- Go at https://kasahorow.com and login.
- Check your mailbox and click on the woaka link.
- Copy the access code available in the login email under 'Consent Code'

**Generate an API access token** -> */api/v1/token*

- Go at https://ayikaile.kasahorow.com/docs and click on the "Authorize" button.
- Use your access code as follows.

```
username=<access_code>@ayikaile.com
password=<access_code>
```

- The generated token will allow you to use the API for a limited period of time (currently 01 day).

You can do it in providing your kasahorow access code as follows.

### Training and usage of the Speech to Text

**Training of the model** -> */api/v1/train*

- Provide a textual representation (ascii prefered) of the word that you want the model to be able to recognize.
- Provide a minimun of 03 audio pronunciations per words (by example 03 audio pronunciations for 'hello', 03 audio pronunciations for 'hi', etc.).
- Make sure to train at least 02 words, otherwise, the model will be unusable.

*NB: Each ayikaile subscriber has a workspace to train and use his own STT model.*

**Test the model** -> */api/v1/stt*

After train the model with at least 02 words, you can test it in sending an audio file.

### License

This documentation is under the MIT license.

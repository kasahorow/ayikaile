# ayikaile

This documentaton act as a completion of the original ayikaile API documentation available at https://ayikaile.kasahorow.com/docs.

It will act as a getting starter for any developer desiring use the API.

### Prerequisites

- Hold an available subscription at https://ayikaile.kasahorow.com.

### Authentification

**Get your access code**

- Go at https://kasahorow.com and login.
- Check your email and click on the woaka link.
- Copy the access code available on the url (eg: https://me.woaka.com?access=<access_code>)

**Generate an API access token**

- Go at https://ayikaile.kasahorow.com/docs and click on the "Authorize" button.
- Use your access code as follows.

```
username=<access_code>@ayikaile.com
password=<access_code>
```

- The generated token will allow you to use the API for a limited period of time (currently 01 day).

You can do it in providing your kasahorow access code as follows.

### Training and usage of the Speech to Text

**Training of the model***

- Provide a textual representation (ascii prefered) of the word that you want the model to be able to recognize.
- Provide a minimun of 03 audio pronunciations per words (by example 03 audio pronunciations for 'hello', 03 audio pronunciations for 'hi', etc.).
- Make sure to train at least 02 words, otherwise, the model will be unusable.

*NB: Each ayikaile subscriber has a workspace to train and use his own STT model.*

**Test the model**

-

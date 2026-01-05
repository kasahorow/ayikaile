# Getting started with AYIKAILE: Multilingual at Work Support by kasahorow

This documentation is for developers looking to integrate the AYIKAILE: Multilingual at Work.

### Content

This documentation is organized in 04 sections.

1. [Authentication](#authentication): the kasahorow developer consent code
2. [Listen](#listen): the kasahorow Speech To Text service
3. [Speak](#speak): the kasahorow Text To Speech service
4. [Read](#read): the translation service
5. [Write](#write): the spellchecking service
6. [Promote](#promote): make money using our advertisement system

### Authentication

**Prerequisites**

- Buy a support package at https://ayikaile.kasahorow.com.

**Get your consent code**

- Go at https://kasahorow.com and login.
- Check your mailbox.
- Copy the access code available in the login mail under 'Consent Code'

### Listen

- Accessible at https://ayikaile.kasahorow.com/docs.
- [How to use](examples/stt).

### Speak

- Accessible at https://api.woaka.com/tts.
- [How to use](examples/tts).

### Read

- Accessible at https://nabanya.kasahorow.com/docs.
- [How to use](examples/translation).

### Write

Not yet available.

### Promote

You just need to add this html code somewhere in your webpage.
And you should replace `<kasa>` with the language that the user speak and `<mkt>` with the language that the user will be happy to learn.
Also, you should replace `<your_domain>` with your domain name.

```html
<div class="text-center">
    <iframe style="width:90%; border:none" src="https://fienipa.kasahorow.com/gua/serve?l=<kasa>&i=<mkt>&e=1&ref=<your_domain>"></iframe>
</div>
```
# Translation

### Get an API token

```sh
curl -X POST "https://nabanya.kasahorow.com/authenticate" -H  "accept: application/json" -H  "Content-Type: application/json" -d '{  "access_code": "your_access_code",  "email": "your_email"}"
```

### Translate from a language to another language

```sh
curl -X POST "https://nabanya.kasahorow.com/translate" -H  "accept: application/json" -H  "Content-Type: application/json" -H  "Authorization: <your_access_token>" -d '{"source": "bai-bbj", "target": "en", "text": "Sɔ’ pəpúŋ", "use_api": true}'

# Translation Output: Good Morning!
```

### Translate from KWL to language

```sh
curl -X POST "https://nabanya.kasahorow.com/translate" -H  "accept: application/json" -H  "Content-Type: application/json" -H  "Authorization: <your_access_token>" -d '{"source": "kwl", "target": "bai-bbj", "text": "pro:he tdy(m(act:hold)) pos:our plural(nom:hand)", "use_api": true}'

# Translation Output: ê ǹtɔ́m pû jɔ́q
```

### Translate from language to KWL

```sh
curl -X POST "https://nabanya.kasahorow.com/translate" -H  "accept: application/json" -H  "Content-Type: application/json" -H  "Authorization: <your_access_token>" -d '{"source": "bai-bbj", "target": "kwl", "text": "tá ǎ kə̄ vʉ̄ ʃjə̄", "use_api": true}'

# Translation Output: pos:my nom:father tdy(me(act:fell)) pre:inside det:the(nom:river)
```

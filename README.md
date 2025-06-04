
In-game utility for managing and revisioning links in your mods/saves.

Steam Workshop Submission: https://steamcommunity.com/sharedfiles/filedetails/?id=3492813174

Link Manager finds all gameobjects with the tag ´linkmanager´ and replaces previous links/paths according to the provided JSON array.

**Information & Usage Instructions:**

Link Manager expects link to a JSON array with reference (original) and replacement strings:
```js
    [
        {"target":"lmexample/parasol_cards_f.png","link":"https://steamusercontent-a.akamaihd.net/ugc/18402794888444462126/21082589D67FF0E777DF1C93F4A3ADDF2E91F41C/"},
        {"target":"lmexample/parasol_cards_b.png","link":"https://steamusercontent-a.akamaihd.net/ugc/10986521115997341997/C947D9CC2FBE8AC0F914A68652E07730F2EF9F95/"},
        {"target":"lmexample/d6s.unity3d","link":"https://steamusercontent-a.akamaihd.net/ugc/14016310337292758413/1BC97B6C1C19E9188EAA0CEF577B53314F5B0DFC/"},
    ]
```
`target` - The path/link to replace

`link` - The path/link replacing `target`

Use the in-game command `!lm f link_to_file.json` or call `lm.call("fetchAssets", "link_to_file.json")` to run the fetch and replace function.

It is recommended that you host the JSON file on Github or a filehost that allows you to update and provide a link with it's contents.

Example: https://raw.githubusercontent.com/cgulia/tts-dynamic-links/refs/heads/main/example/example_assets.json

rm -f hxirc-message-parser.zip
zip -r hxirc-message-parser.zip src test haxelib.json LICENSE README.md *.hxml -x "*/\.*"
haxelib submit hxirc-message-parser.zip

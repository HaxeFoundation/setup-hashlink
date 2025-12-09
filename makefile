setup:
	@haxelib newrepo 2&>/dev/null || true
	haxelib state load install.hxml
	npm i

build:
	haxe build.hxml

clean:
	haxe scripts.hxml --run Clean

dist:
	haxe scripts.hxml --run Dist

publish:
	haxe scripts.hxml --run Publish --cp src --lib tink_core

lint:
	haxelib run checkstyle --exitcode --source src --source scripts --source test


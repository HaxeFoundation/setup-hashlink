package js.actions;

import js.lib.Promise;

@:jsRequire("@actions/github")
extern class Github {
	static function getOctokit(token:String):Octokit;
}

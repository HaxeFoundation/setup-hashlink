package js.actions;

import js.lib.Promise;

@:jsRequire("@actions/github")
extern class Github {
	static function getOctokit(token:String):Octokit;
}

extern class Octokit {
	var rest:OctokitRest;
}

extern class OctokitRest {
	var repos:OctokitRepos;
}

extern class OctokitRepos {
	function getRelease(params:{owner:String, repo:String, release_id:String}):Promise<Dynamic>;
	function getReleaseByTag(params:{owner:String, repo:String, tag:String}):Promise<Dynamic>;
	function getLatestRelease(params:{owner:String, repo:String}):Promise<Dynamic>;
}

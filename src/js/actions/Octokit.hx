package js.actions;

import js.lib.Promise;

/**
	Partial externs for https://octokit.github.io/rest.js/v22/
**/
extern class Octokit {
	var rest:OctokitRest;
}

extern class OctokitRest {
	var repos:OctokitRepos;
}

extern class OctokitRepos {
	/** Gets a public release with the specified release ID. **/
	function getRelease(params:{owner:String, repo:String, release_id:String}):Promise<{data:Release}>;

	/** Get a published release with the specified tag. **/
	function getReleaseByTag(params:{owner:String, repo:String, tag:String}):Promise<{data:Release}>;

	/**
		View the latest published full release for the repository.

		The latest release is the most recent non-prerelease, non-draft release,
		sorted by the `created_at` attribute. The `created_at` attribute is the date
		of the commit used for the release, and not the date when the release was
		drafted or published.
	**/
	function getLatestRelease(params:{owner:String, repo:String}):Promise<{data:Release}>;
}

typedef Release = {
	final url:String;
	final html_url:String;
	final assets_url:String;
	final upload_url:String;
	final tarball_url:Null<String>;
	final zipball_url:Null<String>;
	final id:Int;
	final node_id:String;
	final tag_name:String;
	final target_commitish:String;
	final name:Null<String>;
	final body:Null<String>;
	final draft:Bool;
	final prerelease:Bool;
	final immutable:Bool;
	final created_at:String;
	final published_at:Null<String>;
	final updated_at:Null<String>;
	final author:GithubUser;
	final assets:Array<{
		final id:Int;
		final node_id:String;
		final url:String;
		final browser_download_url:String;
		final name:String;
		final label:Null<String>;
		final state:AssetState;
		final content_type:String;
		final size:Int;
		final digest:Null<String>;
		final download_count:Int;
		final created_at:String;
		final updated_at:Null<String>;
		final uploader:Null<GithubUser>;
		final body_html:String;
		final body_text:String;
		final mentions_count:Int;
		final discussion_url:String;
		final reactions:{}; // TODO
	}>;
}

typedef GithubUser = {
	final name:Null<String>;
	final email:Null<String>;
	final login:Null<String>;
	final id:haxe.Int64;
	final node_id:String;
	final avatar_url:String;
	final gravatar_id:Null<String>;
	final url:String;
	final html_url:String;
	final followers_url:String;
	final following_url:String;
	final gists_url:String;
	final starred_url:String;
	final subscriptions_url:String;
	final organizations_url:String;
	final repos_url:String;
	final events_url:String;
	final received_events_url:String;
	final type:String;
	final site_admin:Bool;
	final starred_at:String;
	final user_view_type:String;
}

enum abstract AssetState(String) {
	var Uploaded = "uploaded";
	var Open = "open";
}

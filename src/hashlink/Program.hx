package hashlink;

import js.actions.Core;
import js.Node;
import tink.Json;
import tink.semver.Constraint;

import hashlink.Release;

/** Application entry point. **/
function main() {
	Node.process.title = "Setup HashLink VM";

	final version = Core.getInput("version");

	function setupRelease(release) {
		new Setup(release).install().handle(outcome -> switch outcome {
			case Failure(error): Core.setFailed(error.message);
			case Success(path): Core.info('HashLink ${release.version} successfully installed in "$path".');
		});
	}

	if (version == "nightly") {
		var token = Core.getInput("GITHUB_TOKEN");
		var octo = js.actions.Github.getOctokit(token);
		octo.rest.repos.getReleaseByTag({owner: "HaxeFoundation", repo: "hashlink", tag: "latest"}).then(res -> {
			for (a in res.data.assets) {
				if (StringTools.endsWith(a.name, "-win64.zip")) {
					var sha = a.name.substring("hashlink-".length, a.name.length - "-win64.zip".length);

					var release = new Release({
						version: "latest",
						assets: [
							new ReleaseAsset({"os": "Windows", "file": 'hashlink-$sha-win64.zip'}),
							new ReleaseAsset({"os": "Mac", "file": 'hashlink-$sha-darwin-cmake.tar.gz'}),
							new ReleaseAsset({"os": "Linux", "file": 'hashlink-$sha-linux-amd64.tar.gz'})
						]
					});

					return setupRelease(release);
				}
			}

			Core.setFailed("Failed to fetch nightlies.");
		});
	} else {
		switch Constraint.parse(version.length == 0 || version == "latest" ? "*" : version) {
			case Failure(_): Core.setFailed("Invalid version constraint.");
			case Success(constraint):
				switch Release.find(constraint) {
					case None: Core.setFailed("No release matching the version constraint.");
					case Some(release): setupRelease(release);
				}
		}
	}
}

import hashlink.Platform;

/** Publishes the package. **/
function main() {
	Sys.command("make dist");
	for (action in ["tag", "push origin"]) Sys.command('git $action v${Platform.packageVersion}');
}

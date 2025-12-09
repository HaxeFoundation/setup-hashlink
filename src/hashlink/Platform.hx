package hashlink;

/** Information about the environment in which the current program is running. **/
abstract class Platform {
	/** The package version of this program. **/
	public static var packageVersion(get, null): String;
		static function get_packageVersion() {
			if (packageVersion == null) packageVersion = #if display "0.0.0" #else getPackageVersion() #end;
			return packageVersion;
		}

	/** Gets the package version of this program. **/
	macro static function getPackageVersion()
		return macro $v{haxe.Json.parse(sys.io.File.getContent("package.json")).version};
}

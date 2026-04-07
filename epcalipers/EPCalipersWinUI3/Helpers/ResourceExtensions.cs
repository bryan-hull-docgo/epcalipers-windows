using Microsoft.Windows.ApplicationModel.Resources;

namespace EPCalipersWinUI3.Helpers
{
	// Note this is brazenly stolen from the Template Studio helper.
	public static class ResourceExtensions
	{
		private static ResourceLoader _resourceLoader;

		public static string GetLocalized(this string resourceKey)
		{
#if TEST
			return resourceKey;
#else
			try
			{
				_resourceLoader ??= new();
				var localized = _resourceLoader.GetString(resourceKey);
				return string.IsNullOrWhiteSpace(localized) ? resourceKey : localized;
			}
			catch
			{
				return resourceKey;
			}
#endif
		}
	}
}

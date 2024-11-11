import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'sw'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? swText = '',
  }) =>
      [enText, swText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // RegistrationPage
  {
    'uwjwwbup': {
      'en': 'Create Account',
      'sw': '',
    },
    'wjfhu2gx': {
      'en': 'First Name',
      'sw': '',
    },
    '5xhsph59': {
      'en': 'Last Name',
      'sw': '',
    },
    'k5pgb2xl': {
      'en': 'Mobile Number',
      'sw': '',
    },
    '251psmsz': {
      'en': 'Password',
      'sw': '',
    },
    '3fafrjgp': {
      'en': 'Confirm Password',
      'sw': '',
    },
    'd7yqhi1a': {
      'en': 'Register',
      'sw': '',
    },
    'gjat968t': {
      'en': 'Already have an account? ',
      'sw': '',
    },
    'lx4hgvpq': {
      'en': 'Login',
      'sw': '',
    },
  },
  // LoginPage
  {
    'wytgli6d': {
      'en': 'Welcome Back',
      'sw': '',
    },
    't9ehnemp': {
      'en': 'Mobile Number',
      'sw': '',
    },
    'y8a7gujh': {
      'en': 'Login',
      'sw': '',
    },
    'n6668593': {
      'en': 'Don\'t have an account? ',
      'sw': '',
    },
    'susm34j8': {
      'en': 'Register',
      'sw': '',
    },
  },
  // OtpPage
  {
    't1o1fg6d': {
      'en': 'OTP Verification',
      'sw': '',
    },
    'wi7j1xzb': {
      'en': 'Enter the 6-digit code sent to your mobile number',
      'sw': '',
    },
    'bkkirvgk': {
      'en': 'Confirm',
      'sw': '',
    },
    '25ve51q8': {
      'en': 'Didn\'t receive the code?',
      'sw': '',
    },
    '0fuqf6u1': {
      'en': 'Request new OTP in',
      'sw': '',
    },
    'y5ppakde': {
      'en': '00:30',
      'sw': '',
    },
  },
  // awardes_offers
  {
    '3cjh4wcy': {
      'en': 'Home',
      'sw': '',
    },
    'efu993f5': {
      'en': 'Pandefy',
      'sw': '',
    },
    'jn58ipy4': {
      'en': 'Search',
      'sw': '',
    },
    'xmxtryqv': {
      'en': 'Awarded',
      'sw': '',
    },
    'wnxt1hgf': {
      'en': 'PESABY HQ',
      'sw': '',
    },
    'dm4h98p0': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    'uuu8i7n9': {
      'en': 'Awarded',
      'sw': '',
    },
    'h770b1b3': {
      'en': '2000',
      'sw': '',
    },
    '1bs6z99g': {
      'en': '5',
      'sw': '',
    },
    '7o7n4c8a': {
      'en': 'Join Us',
      'sw': '',
    },
    '93rxxd0b': {
      'en': 'Printing Works',
      'sw': '',
    },
    'bo2l3npo': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    'vsgi9eeh': {
      'en': 'Waiting',
      'sw': '',
    },
    'l2bdgqg9': {
      'en': '200,000',
      'sw': '',
    },
    'r9dw179n': {
      'en': '7',
      'sw': '',
    },
    'vlcli34g': {
      'en': 'Join Us',
      'sw': '',
    },
    '9mftczu2': {
      'en': 'MTAJI WA SALOON',
      'sw': '',
    },
    'kqaib2lb': {
      'en': 'Suppoerted by: Africab and 3 others',
      'sw': '',
    },
    'x5g43nyc': {
      'en': 'Funded',
      'sw': '',
    },
    'oigzzi4v': {
      'en': '200,000',
      'sw': '',
    },
    'i0y588jy': {
      'en': '7',
      'sw': '',
    },
    'hy9yyup2': {
      'en': 'Join Us',
      'sw': '',
    },
    'hezw61kw': {
      'en': 'Offers',
      'sw': '',
    },
    'k9riq773': {
      'en': 'Pesaby',
      'sw': '',
    },
    'ne8u95g9': {
      'en': 'Michango Kwa Sekunde',
      'sw': '',
    },
    'i4usxw9o': {
      'en': 'Hill Group',
      'sw': '',
    },
    'x070o3qe': {
      'en': 'Feed for every  livestock',
      'sw': '',
    },
    'u3qj7ny5': {
      'en': 'Toyota Tanzania',
      'sw': '',
    },
    '8if1vkfh': {
      'en': 'Let\'s go places.',
      'sw': '',
    },
    '7u6d4xi8': {
      'en': 'Tambuu Motors',
      'sw': '',
    },
    'ynf4397m': {
      'en': 'Kinondoni Studi, kwa bei nafuu kabsa.',
      'sw': '',
    },
    'lzd9y2tl': {
      'en': 'Home',
      'sw': '',
    },
  },
  // catalogsDetails
  {
    'ag1rznxu': {
      'en': 'Website Designing',
      'sw': '',
    },
    'y2twwarn': {
      'en': 'Tshs: 600,000',
      'sw': '',
    },
    'ideqc19n': {
      'en':
          'Get clean, modern and responsive websites, for your personal brand with 1 year FREE hosting, domain, sssl certificates suitable for individuals or small business',
      'sw': '',
    },
    '5918p0nq': {
      'en': 'Buy',
      'sw': '',
    },
    'fps7mg3y': {
      'en': 'Add To Cart',
      'sw': '',
    },
    'tcbpzp02': {
      'en': 'Catalogs Details',
      'sw': '',
    },
    'bexps334': {
      'en': 'Home',
      'sw': '',
    },
  },
  // homepage
  {
    'jzry65v5': {
      'en': 'Status',
      'sw': '',
    },
    'cp7qsk0a': {
      'en': 'Balance',
      'sw': '',
    },
    'ews9uy51': {
      'en': '1,200,000',
      'sw': '',
    },
    'nkny7bqw': {
      'en': 'Withdraw',
      'sw': '',
    },
    'vvsmxqid': {
      'en': 'TOKEN TESTING TEAM',
      'sw': '',
    },
    'mlhv9fnx': {
      'en': 'Created Mar 17, 2020',
      'sw': '',
    },
    'jdtqu29m': {
      'en': '51%',
      'sw': '',
    },
    'o9orxkt7': {
      'en': 'NO 800K CHANGIZO',
      'sw': '',
    },
    'cin12g3a': {
      'en': 'Created Mar 17, 2020',
      'sw': '',
    },
    'y2aj61ji': {
      'en': '21%',
      'sw': '',
    },
    'm0wfswjy': {
      'en': 'TOKEN TESTING TEAM',
      'sw': '',
    },
    'ba77g9h9': {
      'en': 'Created Mar 17, 2020',
      'sw': '',
    },
    '9nnvs6yk': {
      'en': '51%',
      'sw': '',
    },
    'ryl35yx6': {
      'en': 'ALL CHANGIZO',
      'sw': '',
    },
    'bd39fvyl': {
      'en': 'Created Mar 17, 2020',
      'sw': '',
    },
    'mckciib3': {
      'en': '00%',
      'sw': '',
    },
    'wpmhexvi': {
      'en': 'Request',
      'sw': '',
    },
    'zd84hws8': {
      'en': 'NAULI',
      'sw': '',
    },
    'yhog6jjd': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    'pms7pa9j': {
      'en': 'Awarded',
      'sw': '',
    },
    '2syf823a': {
      'en': '200,000',
      'sw': '',
    },
    't285kjo3': {
      'en': 'Supported',
      'sw': '',
    },
    'rrloxxho': {
      'en': '26',
      'sw': '',
    },
    '1mbjhv14': {
      'en': '0',
      'sw': '',
    },
    'pd67c49s': {
      'en': 'Pins',
      'sw': '',
    },
    'ao9z7njq': {
      'en': '11',
      'sw': '',
    },
    'vq468eto': {
      'en': 'Support',
      'sw': '',
    },
    '8fdd94zt': {
      'en': 'MTAJI WA SALOON',
      'sw': '',
    },
    'sce6ia9o': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    'qgf36gae': {
      'en': 'Awarded',
      'sw': '',
    },
    'j4nmuw8z': {
      'en': '200,000',
      'sw': '',
    },
    '4efkwy6h': {
      'en': 'Supported',
      'sw': '',
    },
    '8v04o9ly': {
      'en': '26',
      'sw': '',
    },
    '6nifizz7': {
      'en': '0',
      'sw': '',
    },
    'htcz4a3c': {
      'en': 'Pins',
      'sw': '',
    },
    '9q5wmwsr': {
      'en': '11',
      'sw': '',
    },
    'tx046tw0': {
      'en': 'Support',
      'sw': '',
    },
    '9vpjvg4n': {
      'en': 'NAULI',
      'sw': '',
    },
    '7gxcdjuu': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    'vmdmoqm0': {
      'en': 'Awarded',
      'sw': '',
    },
    'hpfkfxpv': {
      'en': '200,000',
      'sw': '',
    },
    't8krervo': {
      'en': 'Supported',
      'sw': '',
    },
    'lqmrgp17': {
      'en': '26',
      'sw': '',
    },
    'h2u3o4wq': {
      'en': '0',
      'sw': '',
    },
    '3qzn6r69': {
      'en': 'Pins',
      'sw': '',
    },
    'lv1326jy': {
      'en': '11',
      'sw': '',
    },
    'bsnq4jit': {
      'en': 'Support',
      'sw': '',
    },
    'gwzhy8nx': {
      'en': 'NAULI',
      'sw': '',
    },
    'hprn7pic': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    '9i5pnimd': {
      'en': 'Awarded',
      'sw': '',
    },
    'oatt6qri': {
      'en': '200,000',
      'sw': '',
    },
    '0k7iwy7z': {
      'en': 'Supported',
      'sw': '',
    },
    'jhw4ig67': {
      'en': '26',
      'sw': '',
    },
    '5q29jp4l': {
      'en': '0',
      'sw': '',
    },
    'knk0d2uf': {
      'en': 'Pins',
      'sw': '',
    },
    '9zoibkso': {
      'en': '11',
      'sw': '',
    },
    'qxk334sj': {
      'en': 'Support',
      'sw': '',
    },
    'oqfj37ru': {
      'en': 'John Doe',
      'sw': '',
    },
    'zdnqsab1': {
      'en': 'john.j@gmail.com',
      'sw': '',
    },
    'sc764q1s': {
      'en': 'Tracker Notifications',
      'sw': '',
    },
    's7g3tve1': {
      'en': 'Help Center',
      'sw': '',
    },
    's8v72zr5': {
      'en': 'Settings',
      'sw': '',
    },
    'gedr5637': {
      'en': 'Check Offers Available',
      'sw': '',
    },
    'sk6lnkh4': {
      'en': 'Phone Number',
      'sw': '',
    },
    's9qbtxpi': {
      'en': 'Add Number',
      'sw': '',
    },
    'f1ygzqhx': {
      'en': 'Language',
      'sw': '',
    },
    '23fj5gxg': {
      'en': 'English (eng)',
      'sw': '',
    },
    'zlbx7cr1': {
      'en': 'Currency',
      'sw': '',
    },
    'ecehozyf': {
      'en': 'Tzs',
      'sw': '',
    },
    'u1awqk3o': {
      'en': 'Business account Setting',
      'sw': '',
    },
    'fxgd4ir6': {
      'en': 'Notification Settings',
      'sw': '',
    },
    '1k50okpz': {
      'en': 'Log out of account',
      'sw': '',
    },
    '1y52ozfs': {
      'en': 'Log Out?',
      'sw': '',
    },
    'ddb42ejk': {
      'en': 'Pandefy',
      'sw': '',
    },
    'x2g6fq0m': {
      'en': 'Create Request',
      'sw': '',
    },
    'rg0e8lsz': {
      'en': 'Home',
      'sw': '',
    },
  },
  // businessAccount
  {
    'l60i3yx4': {
      'en': 'Pesaby',
      'sw': '',
    },
    '17who5jc': {
      'en': 'Web Development package',
      'sw': '',
    },
    'qc37dghi': {
      'en': 'Tsh 25,000',
      'sw': '',
    },
    'uz3qnadw': {
      'en': 'Okoa muda kwakutumia Gas, Ondokana na usumbufu',
      'sw': '',
    },
    '0snqgt0a': {
      'en': 'Buy',
      'sw': '',
    },
    '8krjlhmp': {
      'en': 'Add to  Cart',
      'sw': '',
    },
    'kp749s05': {
      'en': 'Web Development package',
      'sw': '',
    },
    'jutemyae': {
      'en': 'Tsh 25,000',
      'sw': '',
    },
    'kdsfv3ax': {
      'en': 'Okoa muda kwakutumia Gas, Ondokana na usumbufu',
      'sw': '',
    },
    '6tmkpfjf': {
      'en': 'Buy',
      'sw': '',
    },
    '1zsf393l': {
      'en': 'Add to  Cart',
      'sw': '',
    },
    'l6p9o8t8': {
      'en': 'Web Development package',
      'sw': '',
    },
    'iaqopjsl': {
      'en': 'Tsh 25,000',
      'sw': '',
    },
    'vxvo67aq': {
      'en': 'Okoa muda kwakutumia Gas, Ondokana na usumbufu',
      'sw': '',
    },
    'ohum47uk': {
      'en': 'Buy',
      'sw': '',
    },
    'o1rfrax2': {
      'en': 'Add to  Cart',
      'sw': '',
    },
    'sjgrnr5s': {
      'en': 'Web Development package',
      'sw': '',
    },
    'm57l9wjy': {
      'en': 'Tsh 25,000',
      'sw': '',
    },
    'rkf89vec': {
      'en': 'Okoa muda kwakutumia Gas, Ondokana na usumbufu',
      'sw': '',
    },
    '4y59yhkg': {
      'en': 'Buy',
      'sw': '',
    },
    'uhy6pllr': {
      'en': 'Add to  Cart',
      'sw': '',
    },
    'ppqghsuw': {
      'en': 'Home',
      'sw': '',
    },
  },
  // comment
  {
    'lgirp7sg': {
      'en': 'Comments',
      'sw': '',
    },
    'h4mfr05k': {
      'en': 'GAS REFILS',
      'sw': '',
    },
    'uh2uhfxm': {
      'en': 'Funded 17 March, 2018',
      'sw': '',
    },
    '2rhk2r5r': {
      'en': 'Supported By:',
      'sw': '',
    },
    't6ntrk4v': {
      'en': 'Canadian Harvest',
      'sw': '',
    },
    'aqykml2n': {
      'en': 'Gusa hapa kuvinjari Ofa zaid',
      'sw': '',
    },
    'r4rfb3fg': {
      'en': 'Doffi',
      'sw': '',
    },
    'm8ucrr8g': {
      'en':
          'Sabuni nzuri ya kufulia na huacha ngo na harufu nzuri ya manukato murua.',
      'sw': '',
    },
    'd9580ukv': {
      'en': 'Ally Chakechake',
      'sw': '',
    },
    'nleaqqku': {
      'en': '1 week ago ',
      'sw': '',
    },
    'p9qipf28': {
      'en':
          'Mimi nina laki tatu. naomba laki 4 niongezee nichukue laki tatu kama mkopo',
      'sw': '',
    },
    '7yodszds': {
      'en': '0',
      'sw': '',
    },
    'kzwj4opr': {
      'en': '0',
      'sw': '',
    },
    'y5hxc8sj': {
      'en': 'Ally Chakechake',
      'sw': '',
    },
    'ilyb3sw6': {
      'en': '1 week ago ',
      'sw': '',
    },
    'uo9sa093': {
      'en':
          'Mimi nina laki tatu. naomba laki 4 niongezee nichukue laki tatu kama mkopo',
      'sw': '',
    },
    'l0qsviyn': {
      'en': '3',
      'sw': '',
    },
    'bswnw0o9': {
      'en': '1',
      'sw': '',
    },
    'ujzf4k94': {
      'en': 'Ally Chakechake',
      'sw': '',
    },
    '7n6t5ag2': {
      'en': '1 week ago ',
      'sw': '',
    },
    'e1h46e18': {
      'en':
          'Mimi nina laki tatu. naomba laki 4 niongezee nichukue laki tatu kama mkopo',
      'sw': '',
    },
    '6lr90x2o': {
      'en': '3',
      'sw': '',
    },
    'edzes4nf': {
      'en': '1',
      'sw': '',
    },
    '284dtj1e': {
      'en': 'Ally Chakechake',
      'sw': '',
    },
    'fspzobhk': {
      'en': '1 week ago ',
      'sw': '',
    },
    'uqwff8q0': {
      'en':
          'Mimi nina laki tatu. naomba laki 4 niongezee nichukue laki tatu kama mkopo',
      'sw': '',
    },
    'hqsfomm5': {
      'en': '3',
      'sw': '',
    },
    't9b594gv': {
      'en': '1',
      'sw': '',
    },
    'quu2hw9x': {
      'en': 'Add Comment',
      'sw': '',
    },
    'doann68p': {
      'en': 'Home',
      'sw': '',
    },
  },
  // splashScreen
  {
    't9kp6bqi': {
      'en': 'Support a friend, get double.',
      'sw': '',
    },
  },
  // formSupport
  {
    'qyz90ez7': {
      'en': 'Kiasi cha support',
      'sw': '',
    },
    'auf0rf5x': {
      'en': 'Tsh.',
      'sw': '',
    },
    '7v2ybne1': {
      'en': 'Chagua MNO kwa malipo',
      'sw': '',
    },
    'xyvuasql': {
      'en': 'M-Pesa',
      'sw': '',
    },
    't57lc10b': {
      'en': 'Tigo Pesa',
      'sw': '',
    },
    '1pk4mmw2': {
      'en': 'Airtel Money',
      'sw': '',
    },
    'svubhktj': {
      'en': 'Chagua Mfadhili',
      'sw': '',
    },
    'i0gpeko9': {
      'en': 'Jina la Mfadhili',
      'sw': '',
    },
    'pnzt06s4': {
      'en': 'Matumizi',
      'sw': '',
    },
    'bwnyx49q': {
      'en': 'Andika matumizi',
      'sw': '',
    },
    'hd66wd0a': {
      'en': 'Support',
      'sw': '',
    },
    'ccptv3ch': {
      'en': 'Get',
      'sw': '',
    },
    'jwkzetat': {
      'en': 'Take',
      'sw': '',
    },
    'vm2aybo4': {
      'en': 'Create Request',
      'sw': '',
    },
    'jyk5ciqx': {
      'en': 'Creting Request',
      'sw': '',
    },
  },
  // joins
  {
    'j2tegotg': {
      'en': 'Business Information',
      'sw': '',
    },
    'ss1ecjbs': {
      'en': 'Business Name',
      'sw': '',
    },
    'nknb9xdm': {
      'en': 'Business Caption',
      'sw': '',
    },
    'gkt9w5ch': {
      'en': 'Upload Business Logo',
      'sw': '',
    },
    'n11xvf2k': {
      'en': 'Catalog Creation',
      'sw': '',
    },
    'sk1fdn23': {
      'en': 'Product Name',
      'sw': '',
    },
    '3i21sebs': {
      'en': 'Price (TSh)',
      'sw': '',
    },
    'j3g6ud1w': {
      'en': 'Product Description',
      'sw': '',
    },
    'izyvw4z0': {
      'en': 'Add Product Images',
      'sw': '',
    },
    'mvk76ke8': {
      'en': 'Add Another Product',
      'sw': '',
    },
    'nadsxun0': {
      'en': 'Support Preferences',
      'sw': '',
    },
    '6ip1bofo': {
      'en': 'Allow Support',
      'sw': '',
    },
    'i0zefs54': {
      'en': 'Minimum Support Amount (TSh)',
      'sw': '',
    },
    'v3hy5qgq': {
      'en': 'Support Goal (TSh)',
      'sw': '',
    },
    'h3bc6zwp': {
      'en': 'Save Business Profile',
      'sw': '',
    },
    'mhx9d26g': {
      'en': 'Business Account',
      'sw': '',
    },
  },
  // filterCmponent
  {
    '9px7o0se': {
      'en': 'Waiting',
      'sw': '',
    },
    'qusnh34u': {
      'en': 'Funded',
      'sw': '',
    },
  },
  // paymentoption
  {
    't6mqy82v': {
      'en': 'Choose your preferred payment option',
      'sw': '',
    },
    'yli9eo5k': {
      'en': 'M-Pesa',
      'sw': '',
    },
    'rp6qdjt4': {
      'en': 'Vodacom Tanzania',
      'sw': '',
    },
    'qwohj505': {
      'en': 'Tigo Pesa',
      'sw': '',
    },
    '7qbeizr8': {
      'en': 'Tigo Tanzania',
      'sw': '',
    },
    '75hkmizj': {
      'en': 'Airtel Money',
      'sw': '',
    },
    'efv9x52v': {
      'en': 'Airtel Tanzania',
      'sw': '',
    },
    'ozllge6t': {
      'en': 'CARD ',
      'sw': '',
    },
    'gojjsluu': {
      'en': 'Pay Via Card',
      'sw': '',
    },
    '20ewt1pu': {
      'en': 'Proceed to Payment',
      'sw': '',
    },
  },
  // Miscellaneous
  {
    'q9mano4e': {
      'en': '',
      'sw': '',
    },
    '0lr66rbp': {
      'en': '',
      'sw': '',
    },
    '8i1srvmi': {
      'en': '',
      'sw': '',
    },
    '0p9f2qfd': {
      'en': '',
      'sw': '',
    },
    'ojrh061n': {
      'en': '',
      'sw': '',
    },
    'dx74y2nh': {
      'en': '',
      'sw': '',
    },
    '7fwkbrqh': {
      'en': '',
      'sw': '',
    },
    '2yacton4': {
      'en': '',
      'sw': '',
    },
    'of31krbe': {
      'en': '',
      'sw': '',
    },
    'u3tfbyg3': {
      'en': '',
      'sw': '',
    },
    'bdn2bxnl': {
      'en': '',
      'sw': '',
    },
    'ydzttb0n': {
      'en': '',
      'sw': '',
    },
    'crkb3juu': {
      'en': '',
      'sw': '',
    },
    'e6dp86al': {
      'en': '',
      'sw': '',
    },
    'v6o8q95j': {
      'en': '',
      'sw': '',
    },
    'r2okpp4d': {
      'en': '',
      'sw': '',
    },
    'qj1ya4f7': {
      'en': '',
      'sw': '',
    },
    '0vxjkvev': {
      'en': '',
      'sw': '',
    },
    '7h8uclel': {
      'en': '',
      'sw': '',
    },
    '7cnpjaod': {
      'en': '',
      'sw': '',
    },
    'yuyogfeq': {
      'en': '',
      'sw': '',
    },
    'h47xc25e': {
      'en': '',
      'sw': '',
    },
    'uduoc76n': {
      'en': '',
      'sw': '',
    },
    'h1al9zqx': {
      'en': '',
      'sw': '',
    },
    '83zj0h8v': {
      'en': '',
      'sw': '',
    },
  },
].reduce((a, b) => a..addAll(b));

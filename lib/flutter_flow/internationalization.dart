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
  // offers
  {
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
    '03zq6zzo': {
      'en': 'NAULI',
      'sw': '',
    },
    'lax8ogv9': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    '9einblxc': {
      'en': 'Awarded',
      'sw': '',
    },
    'zwwu0zts': {
      'en': '200,000',
      'sw': '',
    },
    'ufk195l1': {
      'en': 'Supported',
      'sw': '',
    },
    'mph7tiv1': {
      'en': '26',
      'sw': '',
    },
    'meboqfvs': {
      'en': '0',
      'sw': '',
    },
    'txhi6g47': {
      'en': 'Pins',
      'sw': '',
    },
    'msmfeuei': {
      'en': '11',
      'sw': '',
    },
    'ka0kvu96': {
      'en': 'Support',
      'sw': '',
    },
    '1p01iau8': {
      'en': 'MTAJI WA SALOON',
      'sw': '',
    },
    'tqt9zhyr': {
      'en': 'Suppoerted by:Serene Microfinance Ltd',
      'sw': '',
    },
    'wyo67hns': {
      'en': 'Funded',
      'sw': '',
    },
    '7wkmso57': {
      'en': '20,000',
      'sw': '',
    },
    'cgjkd6xn': {
      'en': '7',
      'sw': '',
    },
    'fx4bcpz1': {
      'en': 'Join Us',
      'sw': '',
    },
    'zglxkshn': {
      'en': 'RESEARCH COST',
      'sw': '',
    },
    'ak7q7j75': {
      'en': 'Suppoerted by:Serene Microfinance Ltd',
      'sw': '',
    },
    'i1o6dxe1': {
      'en': 'Waiting',
      'sw': '',
    },
    'y7yd1y22': {
      'en': '20,000',
      'sw': '',
    },
    'oxhbotgz': {
      'en': '0',
      'sw': '',
    },
    'lmwnc5hz': {
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
  // filter
  {
    'lgcgppdd': {
      'en': 'Search',
      'sw': '',
    },
    '0ofmtjsw': {
      'en': 'PESABY HQ',
      'sw': '',
    },
    'y5d88dbm': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    '2zwr7e9c': {
      'en': 'Waiting',
      'sw': '',
    },
    '5ifmeqm4': {
      'en': '200,000',
      'sw': '',
    },
    'fryn01ap': {
      'en': '7',
      'sw': '',
    },
    'fsw9nz1m': {
      'en': 'Join Us',
      'sw': '',
    },
    's3k5p6kg': {
      'en': 'MTAJI WA SALOON',
      'sw': '',
    },
    '54kc3rxh': {
      'en': 'Suppoerted by: Africab and 3 others',
      'sw': '',
    },
    'uvcemozl': {
      'en': 'Funded',
      'sw': '',
    },
    'fkhqexz7': {
      'en': '200,000',
      'sw': '',
    },
    '8ey25u45': {
      'en': '7',
      'sw': '',
    },
    '7h4ab1up': {
      'en': 'Join Us',
      'sw': '',
    },
    'n4u7c8q2': {
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
      'en': 'Get',
      'sw': '',
    },
    'fps7mg3y': {
      'en': 'Save',
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
  // requests
  {
    'dx7istt2': {
      'en': 'NAULI',
      'sw': '',
    },
    'kcjegfk5': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    'd4jlwo16': {
      'en': 'Awarded',
      'sw': '',
    },
    'eib5k62m': {
      'en': '200,000',
      'sw': '',
    },
    'wz3x0to4': {
      'en': 'Supported',
      'sw': '',
    },
    '1579ht3g': {
      'en': '26',
      'sw': '',
    },
    '1xswfovf': {
      'en': '0',
      'sw': '',
    },
    'bkiuyayj': {
      'en': 'Pins',
      'sw': '',
    },
    'gzd58qo2': {
      'en': '11',
      'sw': '',
    },
    'ifmnvpqq': {
      'en': 'Support',
      'sw': '',
    },
    'alk8zd7z': {
      'en': 'MTAJI WA SALOON',
      'sw': '',
    },
    'rbn5g9e1': {
      'en': 'Suppoerted by:Serene Microfinance Ltd',
      'sw': '',
    },
    '80ts7a1d': {
      'en': 'Funded',
      'sw': '',
    },
    'c8aedi1d': {
      'en': '20,000',
      'sw': '',
    },
    '08mor7nw': {
      'en': '7',
      'sw': '',
    },
    'hqkhisrx': {
      'en': 'Join Us',
      'sw': '',
    },
    'niiwjaou': {
      'en': 'RESEARCH COST',
      'sw': '',
    },
    '1375rvki': {
      'en': 'Suppoerted by:Serene Microfinance Ltd',
      'sw': '',
    },
    '17vrw1tc': {
      'en': 'Waiting',
      'sw': '',
    },
    'siztxa6r': {
      'en': '20,000',
      'sw': '',
    },
    'to34jr7m': {
      'en': '0',
      'sw': '',
    },
    'dy2tf9xi': {
      'en': 'Join Us',
      'sw': '',
    },
    't62kjtcq': {
      'en': 'Printing Works',
      'sw': '',
    },
    '4imlrc34': {
      'en': 'Suppoerted by: Africab and 3 others',
      'sw': '',
    },
    'bu2z6vjr': {
      'en': 'Funded',
      'sw': '',
    },
    'z6xpjxqe': {
      'en': '20,000',
      'sw': '',
    },
    'm362vr0p': {
      'en': '0',
      'sw': '',
    },
    'bm98771v': {
      'en': 'Join Us',
      'sw': '',
    },
    '0r5k46ux': {
      'en': 'Requests',
      'sw': '',
    },
    '7af1ulc8': {
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
    'kypeaw7g': {
      'en': 'NAULI',
      'sw': '',
    },
    'y2t9o329': {
      'en': 'Suppoerted by: Tambuu Motors and 3 others',
      'sw': '',
    },
    'p9dj3uh1': {
      'en': 'Awarded',
      'sw': '',
    },
    'nsnt3ljk': {
      'en': '200,000',
      'sw': '',
    },
    'okwfuz3i': {
      'en': 'Supported',
      'sw': '',
    },
    'vyizetgr': {
      'en': '26',
      'sw': '',
    },
    '3ofy3yjj': {
      'en': '0',
      'sw': '',
    },
    '1yfqjdxo': {
      'en': 'Pins',
      'sw': '',
    },
    'zcxgjqd2': {
      'en': '11',
      'sw': '',
    },
    '2x1a1v1n': {
      'en': 'Support',
      'sw': '',
    },
    'pj75vi1v': {
      'en': 'MTAJI WA SALOON',
      'sw': '',
    },
    'grx5ohw0': {
      'en': 'Suppoerted by:Serene Microfinance Ltd',
      'sw': '',
    },
    'vf6yia9q': {
      'en': 'Funded',
      'sw': '',
    },
    'jdzvuds4': {
      'en': '20,000',
      'sw': '',
    },
    'obz2mns1': {
      'en': '7',
      'sw': '',
    },
    'wgeyv7gy': {
      'en': 'Join Us',
      'sw': '',
    },
    'vy4tmnya': {
      'en': 'RESEARCH COST',
      'sw': '',
    },
    '8rcvcjtj': {
      'en': 'Suppoerted by:Serene Microfinance Ltd',
      'sw': '',
    },
    'p5tonmj0': {
      'en': 'Waiting',
      'sw': '',
    },
    'vk2qmjyz': {
      'en': '20,000',
      'sw': '',
    },
    'uw4x09dk': {
      'en': '0',
      'sw': '',
    },
    'ymts7f0x': {
      'en': 'Join Us',
      'sw': '',
    },
    'gl514ppy': {
      'en': 'Printing Works',
      'sw': '',
    },
    'r3816i2f': {
      'en': 'Suppoerted by: Africab and 3 others',
      'sw': '',
    },
    'hli9mg38': {
      'en': 'Funded',
      'sw': '',
    },
    'dvbd8amq': {
      'en': '20,000',
      'sw': '',
    },
    'giwnsfob': {
      'en': '0',
      'sw': '',
    },
    'v3ghxgxk': {
      'en': 'Join Us',
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
      'en': 'Profile Settings',
      'sw': '',
    },
    'qi6qor9i': {
      'en': 'Edit Profile',
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
    'we2hkb52': {
      'en': 'Mkopo kwa Vikundi',
      'sw': '',
    },
    '6f9lwhku': {
      'en': 'Tsh 1,000,000',
      'sw': '',
    },
    'oipqzqlv': {
      'en': 'Karibu tukuhudumie leo Express',
      'sw': '',
    },
    'fvbj73it': {
      'en': 'Buy',
      'sw': '',
    },
    '5z4icahm': {
      'en': 'Add to  Cart',
      'sw': '',
    },
    '6yxtk8p8': {
      'en': 'Lipa Mdogo Mdogo Gas',
      'sw': '',
    },
    'ait0aovq': {
      'en': 'Tsh 25,000',
      'sw': '',
    },
    '5yjwxz35': {
      'en': 'Okoa muda kwakutumia Gas, Ondokana na usumbufu',
      'sw': '',
    },
    'qzfx3ncr': {
      'en': 'Buy',
      'sw': '',
    },
    'n4u6j7ce': {
      'en': 'Add to  Cart',
      'sw': '',
    },
    '36jbhie8': {
      'en': 'Gas Fasta',
      'sw': '',
    },
    '80ocwfzk': {
      'en': 'Tsh 25,000',
      'sw': '',
    },
    'saz8g914': {
      'en': 'Okoa muda kwakutumia Gas, Ondokana na usumbufu',
      'sw': '',
    },
    'xs0aqsz0': {
      'en': 'Buy',
      'sw': '',
    },
    '2ymuozlf': {
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
    '5m1swqtl': {
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
    'ww8u1aw7': {
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

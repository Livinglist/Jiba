import 'package:rxdart/rxdart.dart';

import 'package:jiba/resources/repository.dart';
import 'package:jiba/models/journal.dart';

export 'package:jiba/models/journal.dart';

class JournalBloc {
  BehaviorSubject<List<Journal>> _journalFetcher = BehaviorSubject<List<Journal>>();
  BehaviorSubject<Journal> _incompleteJournalFetcher = BehaviorSubject<Journal>();

  Stream<List<Journal>> get allJournals => _journalFetcher.stream;
  Stream<Journal> get incompleteJournal => _incompleteJournalFetcher.stream;

  List<Journal> _allJournals = <Journal>[];
  Journal _incompleteJournal;

  bool _hasIncompleteJournal = false;
  bool get hasIncomplete => _hasIncompleteJournal;

  int nextId;

  Future fetchAllJournals() async {
    _allJournals = await repo.getAllJournals();

    _allJournals.sort((a, b) => b.createdDate.compareTo(a.createdDate));


   // _allJournals.add(Journal(
   //     fontFamily: noto,
   //     content:
   //     "欢迎来到言己。",
   //     createdDate: DateTime(2021, 3, 12),
   //     id: 888));
   // _allJournals.add(Journal(
   //     fontFamily: noto,
   //     content:
   //     "三月春暖花开，东部一大波大学开始放春假，我的也不例外，最近开始寻找理想的度假目的地。",
   //     createdDate: DateTime(2021, 2, 12),
   //     id: 878));
   // //
   // _allJournals.add(Journal(
   //     fontFamily: noto,
   //     content:
   //         "他们所有的设备和仪器仿佛都像是有生命的。",
   //     createdDate: DateTime(2020, 12, 7),
   //      id: 88));
   //  _allJournals.add(Journal(
   //      fontFamily: noto,
   //      content:
   //      "Naita toden pikku mihin kas hassu tee. En oikeata minahan te vaikkei rapylat menesty. Ai tuommoinen menettelet ryypattiin sinullekin lainattiin jo en kahvipannu. ",
   //      createdDate: DateTime(2020, 12, 4),
   //      id: 88));
   // _allJournals.add(Journal(
   //     fontFamily: noto,
   //     content:
   //     "Naita toden pikku mihin kas hassu tee. En oikeata minahan te vaikkei rapylat menesty. Ai tuommoinen menettelet ryypattiin sinullekin lainattiin jo en kahvipannu. No et eiko puhe ryit ja asia he. Saa jolloin jaa ajaakos tuloaan torjuen karille. Tiesi eri kysyy laski onhan etten mikas luo. Oikeata nokkaan rahaksi ota kas. ",
   //     createdDate: DateTime(2020, 7, 8),
   //     id: 89));
   // _allJournals.add(Journal(
   //     fontFamily: noto,
   //     content:
   //     "Naita toden pikku mihin kas hassu tee. En oikeata minahan te vaikkei rapylat menesty. Ai tuommoinen menettelet ryypattiin sinullekin lainattiin jo en kahvipannu. No et eiko puhe ryit ja asia he. Saa jolloin jaa ajaakos tuloaan torjuen karille. Tiesi eri kysyy laski onhan etten mikas luo. Oikeata nokkaan rahaksi ota kas. ",
   //     createdDate: DateTime(2020, 7, 9),
   //     id: 90));
   // _allJournals.add(Journal(
   //     fontFamily: noto,
   //     content:
   //     "Naita toden pikku mihin kas hassu tee. En oikeata minahan te vaikkei rapylat menesty. Ai tuommoinen menettelet ryypattiin sinullekin lainattiin jo en kahvipannu. No et eiko puhe ryit ja asia he. Saa jolloin jaa ajaakos tuloaan torjuen karille. Tiesi eri kysyy laski onhan etten mikas luo. Oikeata nokkaan rahaksi ota kas. ",
   //     createdDate: DateTime(2020, 7, 10),
   //     id: 91));
   // _allJournals.add(Journal(
   //     fontFamily: noto,
   //     content:
   //     "Naita toden pikku mihin kas hassu tee. En oikeata minahan te vaikkei rapylat menesty. Ai tuommoinen menettelet ryypattiin sinullekin lainattiin jo en kahvipannu. No et eiko puhe ryit ja asia he. Saa jolloin jaa ajaakos tuloaan torjuen karille. Tiesi eri kysyy laski onhan etten mikas luo. Oikeata nokkaan rahaksi ota kas. ",
   //     createdDate: DateTime(2020, 7, 13, 22),
   //     id: 92));


//    String str = "Ab am es angenommen da halboffene uberwunden. Flei habe soll oder das alt. Ehe umwolkt kapelle dir diesmal stiefel bosheit. "
//        "Argerlich wunderbar hol verstehen nebendran senkrecht sie blo wie. Gebaut wahres madele seines gro vom ihm mutter. "
//        "Fragen und minute ruhten mussen uhr. Te du um moge leer heut zu. Freute in ja je braves leicht. "
//        "Dazwischen dammerigen kartoffeln erhaltenen es wasserkrug augenblick um.";
//    for (int i = 1; i < 900; i++) {
//      _allJournals.add(Journal(
//          fontFamily: Pacifico,
//          content: str.substring(0, (Random(i).nextInt(str.length))),
//          createdDate: DateTime.now().subtract(Duration(days: i)),
//          id: 112 + i));
//    }

//    _allJournals.add(Journal(
//        fontFamily: Pacifico,
//        content:
//        "Ab am es angenommen da halboffene uberwunden. Flei habe soll oder das alt. Ehe umwolkt kapelle dir diesmal stiefel bosheit. "
//            "Argerlich wunderbar hol verstehen nebendran senkrecht sie blo wie. Gebaut wahres madele seines gro vom ihm mutter. "
//            "Fragen und minute ruhten mussen uhr. Te du um moge leer heut zu. Freute in ja je braves leicht. "
//            "Dazwischen dammerigen kartoffeln erhaltenen es wasserkrug augenblick um.",
//        createdDate: DateTime(2020, 2, 2),
//        id: 111));
//    _allJournals.add(Journal(
//        fontFamily: Pacifico,
//        content:
//        "Ab am es angenommen da halboffene uberwunden. Flei habe soll oder das alt. Ehe umwolkt kapelle dir diesmal stiefel bosheit. "
//            "Argerlich wunderbar hol verstehen nebendran senkre.",
//        createdDate: DateTime(2020, 2, 5),
//        id: 222));
//    _allJournals.add(Journal(
//        fontFamily: Pacifico,
//        content:
//        "Ab am es angenommen da halboffene uberwunden. Flei habe soll oder das alt. Ehe umwolkt kapelle dir diesmal stiefel bosheit. "
//            "Argerlich wunderbar hol verstehen nebendran senkrecht sie blo wie. Gebaut wahres madele seines gro vom ihm mutter. "
//            "Fragen und minute ruhten mussen uhr. Te du um moge leer heut zu. Fr",
//        createdDate: DateTime(2020, 2, 6),
//        id: 333));
//    _allJournals.add(Journal(
//      fontFamily: Pacifico,
//        content:
//            "Ab am es angenommen da halboffene uberwunden. Flei habe soll oder das alt. Ehe umwolkt kapelle dir diesmal stiefel bosheit. "
//                "Argerlich wunderbar hol verstehen nebendran senkrecht sie blo wie. Gebaut wahres madele seines gro vom ihm mutter. "
//                "Fragen und minute ruhten mussen uhr. Te du um moge leer heut zu. Freute in ja je braves leicht. "
//                "Dazwischen dammerigen kartoffeln erhaltenen es wasserkrug augenblick um.",
//        createdDate: DateTime(2019, 1, 1),
//        id: 100));

    _journalFetcher.sink.add(_allJournals);

    if (_allJournals.isNotEmpty && _allJournals.first.createdDate.isTheSameDay(DateTime.now())) {
      _incompleteJournal = _allJournals.first;
      _hasIncompleteJournal = true;

      print("The incomplete journal is ${_incompleteJournal.content}");

      _incompleteJournalFetcher.sink.add(_incompleteJournal);
    } else {
      _incompleteJournal = null;
      _hasIncompleteJournal = false;

      _incompleteJournalFetcher.sink.add(_incompleteJournal);
    }

    return _allJournals;
  }

  void updateJournal(Journal journal) {
    _allJournals[_allJournals.indexWhere((element) => element.id == journal.id)] = journal;
    repo.updateJournal(journal);

    _incompleteJournal = journal;
    _incompleteJournalFetcher.sink.add(_incompleteJournal);

    _journalFetcher.sink.add(_allJournals);
  }

  void addJournal(Journal journal) {
    //If the same day, replace it.
    if (_allJournals.isNotEmpty && _allJournals.first.createdDate.isTheSameDay(journal.createdDate)) {
      _allJournals[0] = journal;

      repo.updateJournal(journal);
    } else {
      //Not using _allJournals.add(journal); because the list is sorted from newest to oldest
      _allJournals.insert(0, journal);

      //Add to database
      repo.addJournal(journal);
    }

    _journalFetcher.sink.add(_allJournals);

    _incompleteJournal = journal;
    _incompleteJournalFetcher.sink.add(_incompleteJournal);
  }

  void removeJournal(Journal journal) {
    _allJournals.remove(journal);

    //Delete from database
    repo.deleteJournal(journal);

    _journalFetcher.sink.add(_allJournals);

    if (journal.createdDate.isTheSameDay(DateTime.now())) {
      _incompleteJournal = null;
      _hasIncompleteJournal = false;
      _incompleteJournalFetcher.sink.add(_incompleteJournal);
    }
  }

  static const int journalPerPage = 20;
  void getNextPage() {}

  void getPreviousPage() {}

  Future<int> getNextId() async => nextId == null ? repo.getNextId().then((value) => nextId = value) : Future.value(nextId);

  dispose() {
    _journalFetcher.close();
    _incompleteJournalFetcher.close();
  }
}

JournalBloc journalBloc = JournalBloc();

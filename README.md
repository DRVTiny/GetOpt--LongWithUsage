GetOpt--LongWithUsage
=====================

Simple extension to standart Getopt::Long, that provides auto-usage capability without bullshit

EXAMPLE
=======

(From real-life utility. There is some russian text... sorry :) )
<pre>
my %options;
@options{('staticData','lstConnPars','excludeGroups','lstBlockSeq','lstColMap','lstMethods2Debug','CSVFldSep')}=
         (substr($0,0,rindex($0,".")).'.dat',[],[],[],[],[],DFLT_CSV_FIELD_SEP,DFLT_TEXT_QUOTE);         

my %OptsDescr=(
            'synopsis'=>$0.' -s @CONNECT_OPTIONS [-g INCLUDE_GROUP] [-x @EXCLUDE_GROUPS] [-b @BLOCK_SEQ] [-d OUTDIR] [-t] [-o] [-v{1,}] [-m @COLUMN_MAP] [-f FLD_SEP] [-q TEXT_QUOTE]',
            'params'=>[
              [['t','show-triggers'],'!', \$options{'flShowTriggers'},'Добавить информацию о триггерах'],
              [['x','exclude-groups'],'=s@',$options{'excludeGroups'},'Исключить группы (параметр может быть указан несколько раз)'],
              [['g','only-groups'],'=s@',\$options{'searchGroupName'},'Вывести информацию только по группам с именами, соответствующими шаблону'],
              [['o','stdout'],'',\$options{'flWriteToSTDOUT'},'Выводить результат в стандартный поток вывода, а не в файл'],
              [['s','server'],'=s{3}',$options{'lstConnPars'},'Список параметров подключения к серверу фронтенда Zabbix: ИмяХоста Логин Пароль'],
              [['d','dirpath'],'=s',\$options{'pthWorkDir'},'Путь для сохранения файлов результата'],
              [['m','column-map'],'=i{1,100}',$options{'lstColMap'},'Порядок следования столбцов вывода (для перестановки столбцов и/или сокращения их количества)'],
              [['f','field-sep'],'=s',\$options{'CSVFldSep'},'Разделитель полей в CSV-выводе'],
              [['q','text-quote'],'=s',\$options{'TextQuote'},'Тип кавычек для обрамления текстовых пполей'],
              [['v','verbose'],'+',\$options{'flBeVerbose'},'Уровень подробности вывода отладочных соообщений (допускает многократное указание для повышения подробности вывода)'],
              [['b','blockseq'],'=s{1,100}',$options{'lstBlockSeq'},'Последовательность вывода блоков информации. Пример: -b "Host" "Item" "Group"'],
              [['data-here'],'=s',\$options{'staticData'},'Путь к файлу со статическими данными (описание формата CSV и пр.)'],
              [['debug-api-methods'],'=s{1,30}',$options{'lstMethods2Debug'},'Включить отладку для перечисленных методов Zabbix API'],
            ]
           );

GetOptsAndUsage(\%OptsDescr);

print "Following options was passed to me: \n".Dumper(\%options) if $options{'flBeVerbose'};

</pre>

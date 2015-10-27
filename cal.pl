#!perl -w
###http://blog.chinaunix.net/uid-20443874-id-1945895.html

my ($minYear, $maxYear) = (1900, 2049); #能转换的最小与最大公历年份
my ($minSolarMonth, $minSolarDay) = (1, 31); #1900年1月31日为该年农历正月初一
my ($minLunarMonth, my $minLunarDay) = (1, 1);
my @nDayLeap = qw{ 0 31 29 31 30 31 30 31 31 30 31 30 31 };         #闰年对应的各月天数
my @nDayNonLeap = qw{ 0 31 28 31 30 31 30 31 31 30 31 30 31 };    #平年对应的各月天数
my @termInfo = qw{ 0 21208 42467 63836 85337 107014 128867 150921
                                     173149 195551 218072 240693 263343 285989 308563 331033
                                     353350 375494 397447 419210 440795 462224 483532 504758};
my @gan = qw{庚 辛 壬 癸 甲 乙 丙 丁 戊 己};
my @zhi = qw{子 丑 寅 卯 辰 巳 午 未 申 酉 戌 亥};
my @animals = qw{鼠 牛 虎 兔 龙 蛇 马 羊 猴 鸡 狗 猪};
my @solarTerm = qw{小寒 大寒 立春 雨水 惊蛰 春分 清明 谷雨 立夏 小满 芒种 夏至
     小暑 大暑 立秋 处暑 白露 秋分 寒露 霜降 立冬 小雪 大雪 冬至};
my @numberZH = qw{正 一 二 三 四 五 六 七 八 九 十 十一 十二};
my @monthName = qw{ JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC };
my @lunarData = qw{
    19416 19168 42352 21717 53856 55632 91476 22176 39632 21970
    19168 42422 42192 53840 119381 46400 54944 44450 38320 84343
    18800 42160 46261 27216 27968 109396 11104 38256 21234 18800
    25958 54432 59984 28309 23248 11104 100067 37600 116951 51536
    54432 120998 46416 22176 107956 9680 37584 53938 43344 46423
    27808 46416 86869 19872 42416 83315 21168 43432 59728 27296
    44710 43856 19296 43748 42352 21088 62051 55632 23383 22176
    38608 19925 19152 42192 54484 53840 54616 46400 46752 103846
    38320 18864 43380 42160 45690 27216 27968 44870 43872 38256
    19189 18800 25776 29859 59984 27480 21952 43872 38613 37600
    51552 55636 54432 55888 30034 22176 43959 9680 37584 51893
    43344 46240 47780 44368 21977 19360 42416 86390 21168 43312
    31060 27296 44368 23378 19296 42726 42208 53856 60005 54576
    23200 30371 38608 19415 19152 42192 118966 53840 54560 56645
    46496 22224 21938 18864 42359 42160 43600 111189 27936 44448
    84835
};
my $epochOffset = &nSolarDayPassed(1970, 1, 1);

# 
# if( @ARGV != 2 ){ print "Invalid number of arguments!\n"; &printHelp(); exit; }
# 
# my $dir = shift @ARGV;
# if( $dir eq "-s" ){    #公历转农历
# 
#     my ($year, $month, $day) = &parseSolarDate(shift @ARGV);    #
# 
#     my ($lYear, $lMonth, $lDay, $isLeapMonth) = &solar2Lunar( $year, $month, $day );
#     
#     my $strSDate = &strSolarDate($year, $month, $day);    #公历的字符串表示
# 
#     my $strLYear = &strLunarYear( $year, $month, $day );    #农历的年份表示
# 
#     my $strLDate = &strLunarDate( $lMonth, $lDay, $isLeapMonth );    #农历的月日表示
# 
#     print "\t您输入的是公历$strSDate, 是 $strLYear,农历$strLDate\n";
# }
# elsif( $dir eq "-l" ){    #农历转公历
# 
#     my ($year, $month, $day, $isLeapMonth) = &parseLunarDate(shift @ARGV);
#     my ($sYear, $sMonth, $sDay) = &lunar2Solar($year, $month, $day, $isLeapMonth);
#     
#     my $strLYear = &strLunarYear( $sYear, $sMonth, $sDay );
#     my $strLDate = &strLunarDate( $month, $day, $isLeapMonth );
#     my $strSDate = &strSolarDate( $sYear, $sMonth, $sDay );
#     print "\t您输入的是$strLYear,农历$strLDate, 是 公历$strSDate\n";
# }
# else{    #不认识的参数
# 
#     print "Unkown arguments $dir!\n"; &printHelp(); exit;
# }

#################################将公历某年某月某日转为农历某月某日

sub solar2Lunar()
{
    my ($year, $month, $day) = (1900, 1, 1);
    my $isLeapMonth; #转换成的农历月份是否是闰月

    my $offset = &nSolarDayPassed( @_ );
    $offset -= 30; #事实上只计算自1900年1月31日起的公历转农历，因此先减去31

    
    my $temp = &nDayLunarYear($year);
    while( $offset >= $temp ){
        $offset -= $temp;
        $year++;
        $temp = &nDayLunarYear($year);
    }

    $temp = &nDayLunarMonth($year, $month);
    my $theLeapMonth = &leapMonth($year);
    while( $offset >= $temp ){
        $offset -= $temp;
        if( $theLeapMonth == $month ){
            my $t = &nDayLeapMonth($year);
            if( $offset >= $t ){ $offset -= $t; }
            else{ $isLeapMonth = 1; last; }
        }
        $month++;
        $temp = &nDayLunarMonth($year, $month);
    }
    
    $day += $offset;
#    print "Lunar $year年" . ($isLeapMonth ? "闰" : "") . "$month月$day日 \n";

    ($year, $month, $day, $isLeapMonth);
}

#################################将农历某年某月某日转换为公历

###年是指当年春节所在的公历年份，因此农历2007年12月应是公历2008年

sub lunar2Solar()
{
    my ($year, $month, $day) = (1900, 1, 1);
    my $offset = &nLunarDayPassed( @_ );
    $offset += 30; #农历1900年1月1日已经是公历的1月31日

    
    my $temp = &nDaySolarYear( $year );
    while( $offset >= $temp ){
        $offset -= $temp;
        $year++;
        $temp = &nDaySolarYear( $year );
    }
    
    $temp = &nDaySolarMonth($year, $month);
    while( $offset >= $temp ){
        $offset -= $temp;
        $month++;
        $temp = &nDaySolarMonth($year, $month);
    }
    
    $day += $offset;
    
    ($year, $month, $day);
}

#################################计算某年农历的天数

sub nDayLunarYear()
{
    my $sum = 348; my $i;
    for( $i = 0x8000; $i > 0x8; $i >>= 1 ){ $sum += ($lunarData[$_[0] - $minYear] & $i) ? 1 : 0; }
    my $theLeapMonth = &leapMonth($_[0]);
    if( $theLeapMonth ){ $sum += &nDayLeapMonth($_[0]); }
    $sum;
}

#################################计算公历某年的天数

sub nDaySolarYear()
{
    &isLeap( $_[0] ) ? 366 : 365;
}

#################################计算某年农历闰哪个月

sub leapMonth()
{
    hex(0xF & $lunarData[$_[0] - $minYear]);
}

#################################计算某年农历闰月的天数，没闰月返回0

sub nDayLeapMonth()
{
    if( &leapMonth($_[0]) ){    ($lunarData[$_[0] - $minYear] & 0x10000) ? 30 : 29; }
    else{ 0 }
}

#################################计算农历某年某非闰月的天数

sub nDayLunarMonth()
{
    my $day = 29;
    $day += $lunarData[$_[0] - $minYear] & ( 0x10000 >> $_[1] ) ? 1 : 0;
}

#################################计算公历某年某月的天数

sub nDaySolarMonth()
{
    &isLeap( $_[0] ) ? $nDayLeap[$_[1]] : $nDayNonLeap[$_[1]];
}

#################################计算公历某年某月某日离1900年1月1日的天数，最小为0

sub nSolarDayPassed()
{
    my ($year, $month, $day) = @_;
    my ($leap, $nDay, $y, $m);
    
    $leap = 0;
    for( $y = $minYear; $y < $year; $y++){
        $leap = &isLeap($y);
     $nDay += $leap ? 366 : 365;
    }
    
    for( $m = 1; $m < $month; $m++ ){
        $nDay += &nDaySolarMonth($year, $m);
    }
    
    $nDay += $day - 1;
}

#################################计算农历某年某月某日离1900年正月一日的天数

###（即公历1900年1月31日），最小为0

sub nLunarDayPassed()
{
    my ($year, $month, $day, $isLeapMonth ) = @_;
    my ($nDay, $y, $m);
    for( $y = $minYear; $y < $year; $y++ ){
        $nDay += &nDayLunarYear($y);
    }
    for( $m = 1; $m < $month; $m++ ){
        $nDay += &nDayLunarMonth($year, $m);
    }
    
    if( $isLeapMonth ){ $nDay += &nDayLunarMonth($year, $m); }
    $nDay += $day - 1;
}

#################################计算公元某年为农历哪年，用干支索引表示

sub ganZhi()
{
    my ($year, $month, $day) = @_;
    if( $month == 1 ){ $year--;    }
    elsif( $month == 2 && $day < 7){#    每年的立春似乎是2月的4号或5号

        my ($liChunM, $liChunD) = &term($year, 2);
        if( $day < $liChunD ){    #从立春之日起农历干支年才加一年

            $year--;    
        }
    }

    my $ganIndex = ($year - $minYear) % 10;
    my $zhiIndex = ($year - $minYear) % 12;
    
    ($ganIndex, $zhiIndex);
}

########

sub strLunarYear()
{
    my ($year, $month, $day) = @_;
    
    my ($ganInd, $zhiInd) = &ganZhi($year, $month, $day);
    my $str = $gan[$ganInd] . $zhi[$zhiInd] . "年 肖" . $animals[$zhiInd];

}

sub LunarYear()
{
    my ($year, $month, $day) = @_;
    
    my ($ganInd, $zhiInd) = &ganZhi($year, $month, $day);
#    my $str = $gan[$ganInd] . $zhi[$zhiInd] . "年 肖" . $animals[$zhiInd];
      ($gan[$ganInd] , $zhi[$zhiInd],  $animals[$zhiInd])
}

#################################将农历某月某日表示成字符串

sub strLunarDate()
{
    my ($month, $day, $isLeapMonth) = @_;
    
    my $str .= $isLeapMonth ? "闰" : "";
    
    if( $month == 1 ){ $str .= $numberZH[0]; }
    else{ $str .= $numberZH[$month]; }
    $str .= "月";
    
    if( $day <= 10 ){ $str .= "初" . $numberZH[$day]; }
    elsif( $day <= 19 ){ $str .= "十" . $numberZH[$day - 10] . "日"; }
    elsif( $day == 20 ){ $str .= "二十日"; }
    elsif( $day <= 29 ){ $str .= "廿" . $numberZH[$day - 20] . "日"; }
    else{ $str .= "三十日"; }
    
    $str;
}

sub strLunarDate()
{
    my ($month, $day, $isLeapMonth) = @_;
    
    my $str .= $isLeapMonth ? "闰" : "";
    
    if( $month == 1 ){ $str .= $numberZH[0]; }
    else{ $str .= $numberZH[$month]; }
    $str .= "月";
    
    if( $day <= 10 ){ $str .= "初" . $numberZH[$day]; }
    elsif( $day <= 19 ){ $str .= "十" . $numberZH[$day - 10] . "日"; }
    elsif( $day == 20 ){ $str .= "二十日"; }
    elsif( $day <= 29 ){ $str .= "廿" . $numberZH[$day - 20] . "日"; }
    else{ $str .= "三十日"; }
    
    $str;
}

#################################将公历某年某月某日表示成字符串

sub strSolarDate()
{
    $_[0] . "年" . $_[1] . "月" . $_[2] . "号";
}

################################将一个八个数字的字串分解为公历xxxx年xx月xx日，同时判断该日期是否有效

sub parseSolarDate()
{
  unless( $_[0] =~ /^\d{8}$/ ){ die "Invalid solar date value $_[0]!"; }
  my $year = substr($_[0], 0, 4);
  my $month = substr($_[0], 4, 2);
  my $day = substr($_[0], 6, 2);

  if( $year < 1900 || $year > 2049){ print "Year should between 1900 and 2049!"; exit; }
  if( $month < 1 || $month > 12){ print "Month should between 1 and 12!"; exit; }
  my $foo = &nDayOfMonth($year, $month);
  if( $day > $foo || $day < 1){ print "Day of $year年$month月 should between 1 and $foo!"; exit; }
  if( $year == 1900 && $month == 1 && $day != 31 ){ print "Can only process date after Jan 31 1900!"; exit; }
  
  ($year, $month, $day);
}
#################################将一个八个数字或月分后加一指示闰月的"L"共九个长的字串

###分解为农历xxxx年xx月xx日及isLeapMonth标志，同时判断该日期是否有效

sub parseLunarDate()
{
    my ($year, $month, $day, $isLeapMonth );
    
    if( $_[0] =~ /^\d{8}$/ ){    $isLeapMonth = 0; }
    elsif( $_[0] =~ /^\d{6}[L|l]\d{2}$/ ){ $isLeapMonth = 1; }
    else{ die "Invalid lunar date value $_[0]!"; }
    
    $year = substr($_[0], 0, 4);
    $month = substr($_[0], 4, 2);
    if( $isLeapMonth ){ $day = substr($_[0], 7, 2); }
    else{ $day = substr($_[0], 6, 2); }
    
    if( $year < 1900 || $year > 2049){ print "Year should between 1900 and 2049!"; exit; }
  if( $month < 1 || $month > 12){ print "Month should between 1 and 12!"; exit; }
  my $foo;
  if( $isLeapMonth ){
      if( &leapMonth($year) != $month ){ print "$month is not a leap month in year $year!"; exit; }
      $foo = &nDayLeapMonth($year);
  }else{
      $foo = &nDayLunarMonth($year, $month);
  }
  if( $day < 1 || $day > $foo ){
      print "Day of $year年" . ($isLeapMonth ? "闰" : "") . "$month月 should between 1 and $foo!";
      exit;
  }
  
    ($year, $month, $day, $isLeapMonth);
}

#################################计算公历某年某月的天数

sub nDayOfMonth()
{
  if( &isLeap($_[0]) ){ $nDayLeap[$_[1]]; }
  else{ $nDayNonLeap[$_[1]]; }
}

#################################判断公历某年是否为闰年

sub isLeap()
{
    ( $_[0] % 4 == 0 && $_[0] % 100 != 0 ) || ( $_[0] % 400 == 0 );
}

#################################

sub lunar_2()
{
    my $i, my $leap=0, my $temp=0;
    my $offset = &nDayPassed($_[0], $_[1], $_[2]);
    my ($year, $month, $day);
    for($i=1900; $i<2050 && $offset>0; $i++) { $temp=&nDayLunarYear($i); $offset-=$temp; }
    if($offset<0) { $offset+=$temp; $i--; }
    
    $year = $i;
    $leap = &leapMonth($i); ##闰哪个月

    $isLeap = 0;
    
    for($i=1; $i<13 && $offset>0; $i++) {
        ##闰月

        if($leap>0 && $i==($leap+1) && $isLeap==0)
        { --$i; $isLeap = 1; $temp = &nDayLeapMonth($year); }
        else
        { $temp = &nDayLunarMonth($year, $i); }
        ##解除闰月

        if($isLeap==1 && $i==($leap+1)){ $isLeap = 0; }
        
        $offset -= $temp;
    }
    
    if($offset==0 && $leap>0 && $i==$leap+1){
        if($isLeap){ $isLeap = 0; }
        else{ $isLeap = 1; --$i; }
    }
    if($offset<0){ $offset += $temp; --$i; }
    
    $month = $i;
    $day = $offset + 1;
    ($year, $month, $day)
}

#################################计算某年第n个(0为小寒)节气是几号（公历）

sub term()
{
    my $microsec = 31556925974.7*($_[0]-1900) + $termInfo[$_[1]]*60000 - 2_208_549_300_000;
    my $offset = $microsec / 86400000 + $epochOffset;
    my ($year, $month, $day) = (1900, 1, 1);
    
    my $temp = &nDaySolarYear( $year );
    while( $offset >= $temp ){
        $offset -= $temp;
        $year++;
        $temp = &nDaySolarYear( $year );
    }
    
    $temp = &nDaySolarMonth($year, $month);
    while( $offset >= $temp ){
        $offset -= $temp;
        $month++;
        $temp = &nDaySolarMonth($year, $month);
    }
    
    $day += int($offset);
    
    ($month, $day);
}

#################################

sub printHelp()
{
    print "[USAGE]: cal.pl -[s|S]|[l|L] date\n" .
                "[NOTE]: -s|S 表输入的为公历,需要转为农历;-l|L反之\n" .
                " date指8位数字,依次为4位的年份,2位的月份和2位的日数\n" .
                " 当输入的农历月份为闰月时应在月分后用l或L注明，此时共9位\n"
}

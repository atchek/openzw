 
#!/usr/bin/perl
####  this program is written by Ang Tun Chek @2015
#### formula design based on
#### http://www.click108.com.tw/teaching/shiyea001.php
####  http://www.ceming.org/ziwei/
#### http://site.douban.com/108862/widget/notes/3928614/note/204288220/
###https://www.ptt.cc/man/Life/D3AF/M.1294834996.A.E89.html
use strict;

use PERSON;
use MING_GONG;
use Data::Dumper;
## sex  - 0 (Male), 1 (Female)
my $you = PERSON->new("year"=>1967,"month" =>10,"date"=>19,"hour"=>8,"min"=>17,"sex"=>0); 

$you->process();

my $ming_gong = MING_GONG->new("you"=>$you);
print Dumper($you);
print Dumper($ming_gong->ming_gong());

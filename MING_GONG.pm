package MING_GONG;
use strict;
use POSIX;
use Data::Dumper;
# # # #  1、本宮(本方):是一種代名詞，研究命宮則以命宮為本宮，研究夫妻宮則以夫妻宮為本宮。命盤十二宮皆可為本宮。
# # # # 2、對宮(對方):即相對宮位之意，也就是面對本宮的宮位。
# # # # 在論本宮的吉凶時，對宮具有相當大的影響力，其重要性次於本宮。在命盤上，子午宮、丑未宮、寅申宮、卯酉宮、辰戌宮、巳亥宮皆互相對照，彼此為對宮。
# # # # 3、鄰宮(鄰方):指位於本宮前一位與後一位的二宮而言，其主要作用在輔助本宮。如以命宮為本宮，則父母宮、兄弟宮為鄰宮。就本宮而言，鄰宮所具有的影響力，不及對宮與三合宮來得重要，但在特殊情況下例外。
# # # # (1)加會：指本宮、對宮、三合宮中的某些星曜會合而言。
# # # # 本宮、對宮、三合宮可視為一個整體進行論斷，此點尤其在推斷命宮吉凶時，就顯得分外重要。
# # # # 而論斷一個人一生的成就，首先看命宮，次看身宮，再看財帛宮、官祿宮、遷移宮的吉凶如何。
# # # # 另外，在推算大限、小限、流年太歲之吉凶時，大限、小限、流年太歲各自的對宮及三命宮須同時參看，不然，論斷時便會發生謬誤和片面。
# # # # 
# # # # (2)守照：某星坐於本宮曰守，照指本宮之三合宮及對宮之星曜與本宮所發生之感應。
# # # # 如「四煞守照夫妻宮」，即是指羊、陀、火、鈴四星中有一星或數星居於夫妻宮，另有一星或數星在夫妻宮的對宮(官祿)、夫妻宮的三合宮(遷移、福德)會合而言。
# # # # 
# # # # 
# # # # 
# # # # 本宮：主事宮曰本宮。
# # # # 例如：命宮主一生之格局，若問終身，則命宮即為本宮。
# # # # 例如：問夫妻以夫妻為本宮，若問兄弟則兄弟宮即為本宮。
# # # # 對宮：本宮之七沖宮曰對宮。或曰朝、沖。例：夫妻宮的對宮便是官祿宮。對宮指的就是所要看的宮位對角線的宮位。兄弟宮的對宮為朋友宮 <---> 朋友宮的對宮為兄弟宮
# # # # 合宮：本宮之三合宮曰合宮，亦稱三合。或曰拱照、協、脅。
# # # # 鄰宮：本宮之前一位及後一位曰鄰宮，亦稱夾宮。或曰輔。
# # # # 四方宮：即本宮、對宮、合宮、鄰宮，合稱曰四方宮。
# # # # 臨照：星落座在本宮曰臨照。
# # # # 沖照：星落座在本宮之對宮曰沖照。
# # # # 合照：星落座在本宮之三合宮曰合照。
# # # # 輔照：雙星分別落座在鄰宮曰輔照。
# # # # 如以命宮為本宮、鄰宮鉊見文昌、文曲曰昌曲輔照。
# # # # 夾宮就是所看宮位(本宮)左右兩旁宮位有出現某些特定的星稱為夾宮。而這些特定的星大多是成雙成對出現的。如左輔、右弼，文昌、文曲，地空、地劫等…但這是命盤排法的必然性，科技紫微網論命的重心並不在這。
# # # #  凶星出現在對宮叫【沖】，吉星出現在對宮則叫【照】
# # # # 主星指的是紫微、天機、太陽、武曲、天同、廉貞、天府、太陰、貪狼、巨門、天相、天梁、七殺、破軍此十四顆星。
# # # #  竹籮三限指的是七殺、破軍、貪狼出現在命宮、財帛宮、事業宮的情況。這也是紫微斗數結構上的一種必然性，也是開創型命盤裡一定會有的組合模式。

# # # # 會與照，三方四正，三方見稱會，對宮見稱照
# # # # 逢是指流年遇上

# # # # 三方四正:  
# # # # 
# # # # 1、本宫(本方):是一种代名词，研究命宫则以命宫为本宫，研究夫妻宫则以夫妻宫为本宫。命盘十二宫皆可为本宫。  
# # # # 
# # # # 2、对宫(对方):即相对宫位之意，也就是面对本宫的宫位。  
# # # # 
# # # # 在论本宫的吉凶时，对宫具有相当大的影响力，其重要性次于本宫。在命盘上，子午宫、丑未宫、寅申宫、卯酉宫、辰戌宫、巳亥宫皆互相对照，彼此为对宫。  
# # # # 
# # # # 3、三合宫(拱照):与本宫地支，有三合关系的宫位，三宫相并而成。  
# # # # 
# # # # 一是根据地支来求:(1)巳酉丑三合；(2)亥卯未三合；(3)申子辰三合；(4)寅午戌三合。  
# # # # 
# # # # 二是以十二宫来求:(1)命宫、财帛宫、官禄宫之三合；(2)兄弟宫、疾厄宫、田宅宫之三合；(3)夫妻宫、迁移宫、福德宫之三合；(4)子女宫、奴仆宫、父母宫之三合。此与地支三合的结果完全相同。  

# # #  	三方指的就是所看的宮位為基準點，往左數第五個宮位、往右數第五個宮位稱為三方，再加上所看宮位的對宮便是四正。
# # # 
# # # 例：命宮的三方為命宮+財帛宮+事業宮。
# # # 　　加上遷移宮則是四正。
# # # 　　兄弟宮的三方為兄弟宮+疾厄宮+田宅宮。
# # # 　　加上朋友宮則是四正。
# # # 　　夫妻宮的三方為夫妻宮+遷移宮+福德宮。
# # # 　　加上事業宮則是四正。
# # # 　　子女宮的三方為兄弟宮+朋友宮+父母宮。
# # # 　　加上田宅宮則是四正。
# # # 　　財帛宮的三方為財帛宮+命 宮+事業宮。
# # # 　　加上福德宮則是四正。
# # # # 四墓
# # # # 辰、戌、丑、未四宫为五行局长生十二星的“墓”所落之地(丑为金之墓，辰为水之墓，未为木之墓，戌为火、土之墓)，故称为“四墓之地”，也为四土库、四墓库；且由于辰、戌、丑、未四宫为孤辰星、寡宿星所入主的宫位，故又称为“孤独地”。命宫在四墓之地，个性保守，刚直忠诚，比较劳碌，也比较认命，一生有如来还债的，孤独，弃祖离宗，若再逢与子女缘薄的破军星、巨门星，则会更孤独。由于辰、戌为天罗地网，立命之人，处心积虑地想破网而出，故流离漂荡在外的特性更为显著。凡事喜独断，且倡言更新，喜左右环境，凭借比他人捷足先登的方式，达到控制的目的。

#http://web.ntnu.edu.tw/~69320010/new_page_7.htm
# 加會，會照：
# 
# .假設命宮有紫微星，遷移宮有右弼，
# 
# 事業宮有文昌，財帛宮有火星，
# 
# 則可稱紫微星加會文昌，右弼，火星。
# 
# .得位：
# 
# .假設紫微它位居兄弟宮或夫妻宮因帝王星落入弱宮,
# 
# 是別人有威儀，有解厄作用，
# 
# 紫微在事業宮時為最有力的位置，稱為得位

sub new {
     my($class)  = shift;
     my(%params) = @_;

     my($self) =  {
	you 	=>$params{you} ,
#         pos  =>$params{pos} ,

      };    
     bless($self, $class);

     return($self);
}


our @fourghosts = ["擎羊","陀羅","火星","鈴星"];
our @sixghosts = ["擎羊","陀羅","火星","鈴星","地空","地劫"];
our @sixlucky = ["文昌","文曲","左輔","右弼","天魁","天鉞"];


#########特别
# # ＊ 紫微為北斗帝星、是事業宮主，當它位居事業宮時為得位，力量最強。
# # ＊ 天機為南斗善星，是兄弟宮主，居兄弟宮為得位，主結交才藝智慧之友。


sub find_stars(){
    my $self = shift;
       my(%params) = @_;
#      my $self->{you} = $params{you};
       my $pos = $params{pos} || $self->{pos};
      my @stars;
      
    #   print Dumper($self->{you});
           foreach my $k  (keys %{$self->{you}->{ziwei}}){
		if($self->{you}->{ziwei}->{$k}->{pos} eq $pos){
		      push @stars, $k;
		      
		 }

	   }
       return @stars;

}

sub find_stars_huaji(){
    my $self = shift;
       my(%params) = @_;
#      my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
      my @stars;
      
#       print Dumper($self->{you});
           foreach my $k  (keys %{$self->{you}->{ziwei}}){
		if($self->{you}->{ziwei}->{$k}->{pos} eq $self->{pos} && $self->{you}->{ziwei}->{$k}->{hua_ji}){
		      push @stars, $self->{you}->{ziwei}->{$k}->{hua_ji};
		      
		 }

	   }
       return @stars;

}


##三合
sub has_shanhe(){
     my $self = shift;
     my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
      my @stars = @{$params{stars}};
      my $count;
      my $totalstars = scalar(@stars);

#       foreach (@stars){
# 	    if($self->{you}->{ziwei}->{$_}->{pos} eq $self->{pos} || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos} +4)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+8)%12){
# 		return 1;
# 	    }
# 
#       }
      foreach (@stars){
	    if( $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos} +4)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+8)%12){
		$count++;
	    }

      }
    if($count eq $totalstars || $count > 2){
      return 1;
    }else{

      return 0;
    }
}


##加會
sub has_jiahui(){
     my $self = shift;
     my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
      my @stars = @{$params{stars}};
      my $totalstars = scalar(@stars);
      my $count;
#  old     foreach (@stars){
# 	    if($self->{you}->{ziwei}->{$_}->{pos} eq $self->{pos} || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos} +4)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+6)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+8)%12){
# 		return 1;
# 	    }
# 
#       }
      foreach (@stars){
	    if( $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos} +4)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+6)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+8)%12){
		$count++;
	    }

      }
    if($count eq $totalstars || $count >=3){
      return 1;
    }else{

      return 0;
    }

}
# # 
# # ##會照
# # sub has_jiahui(){
# #      my $self = shift;
# #      my(%params) = @_;
# # #       my $self->{you} = $params{you};
# # #       my $self->{pos} = $params{pos};
# #       my @stars = @{$params{stars}};
# # 
# #       foreach (@stars){
# # 	    if( $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos} +4)%12 ){
# # 		return 1;
# # 	    }
# # 
# #       }
# # 
# #     return 0;
# # 
# # }

##加會化忌
sub has_jiahui_huaji(){
     my $self = shift;
     my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
    
#   print Dumper($self)."----------";

      my @stars = @{$params{stars}};
      foreach my $huaji (@stars){
# 	    if($self->{you}->{ziwei}->{$_}->{pos} eq $self->{pos} || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos} +4)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+6)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+8)%12){
# 		return 1;
# 	    }

# 	  foreach my $s ($self->find_stars(pos=>$self->{pos}) ){
# 		if($self->{you}->{ziwei}->{$s}->{hua_ji} eq $huaji ){
# 		    return 1;
# 		}
# 	  }

	  foreach my $s ($self->find_stars(pos=> ($self->{pos} +4)%12) ){
		if($self->{you}->{ziwei}->{$s}->{hua_ji} eq $huaji ){
		    return 1;
		}
	  }

	  foreach my $s ($self->find_stars(pos=> ($self->{pos} +6)%12) ){
		if($self->{you}->{ziwei}->{$s}->{hua_ji} eq $huaji ){
		    return 1;
		}
	  }

	  foreach my $s ($self->find_stars(pos=> ($self->{pos} +8)%12) ){
		if($self->{you}->{ziwei}->{$s}->{hua_ji} eq $huaji ){
		    return 1;
		}
	  }

      }

    return 0;

}



##夹宫
sub has_jiagong(){
    my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
      my @stars = @{$params{stars}};
      my $count;
      foreach (@stars){
	    if($self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos} +1)%12 || $self->{you}->{ziwei}->{$_}->{pos} eq ($self->{pos}+11)%12 ){
		$count++;
	    }

      }

    if($count >= 2){
      return 1;
    }else{

      return 0;
    }

}

sub has_huaji(){
    my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
       my $star = $params{star};
      my @stars = @{$params{stars}};

      foreach (@stars){
	    if($self->{you}->{ziwei}->{$star}->{hua_ji} eq $_ ){
		return 1;
	    }

      }

    return 0;

}

sub has_stars(){
    my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
      my @stars = @{$params{stars}};

      
      foreach (@stars){
      
	    if($self->{you}->{ziwei}->{$_}->{pos} eq $self->{pos}  ){
		return 1;
	    }

      }

    return 0;

}

sub has_fourghost(){
     my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
    #  my @stars = @{$params{star}};

 return $self->has_stars(  stars=>@fourghosts ) ;
}

sub has_sixghost(){
     my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
    #  my @stars = @{$params{star}};
#    print "===========".Dumper(@sixghosts);
 return $self->has_stars(  stars=>@sixghosts ) ;
}

sub has_sixlucky(){
     my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
    #  my @stars = @{$params{star}};

 return $self->has_stars(  stars=>@sixlucky ) ;
}

sub born(){
    my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
#       my $self->{pos} = $params{pos};
      my @time = @{$params{time}};

      foreach (@time){
	    if($self->{you}->{gong_gan}->{$self->{pos}} =~ $_){
		return 1;
	    }

      }

    return 0;

}

sub position(){
    my $self = shift;
      my(%params) = @_;
#       my $self->{you} = $params{you};
#     #  my $self->{pos} = $params{pos};
      my @time = @{$params{time}};
      my $pos = $self->{pos};
      foreach my $pos (0..12){
	foreach (@time){
	    if($self->{you}->{gong_gan}->{$pos} =~ $_){
		return $pos;
	    }

	  }
      }

    return -1;

}

sub ming_gong (){
    my $self = shift;
       my(%params) = @_;

	my $you =$self->{you};
 
#       my $you = $params{you};$
      my $gong = "命宫";
      my $res;
      $self->{pos} = $you->{gong_wei}->{$gong};
      #print $self->{pos}."";
      foreach my $k  (keys %{$you->{ziwei}}){

	if($you->{ziwei}->{$k}->{pos} eq $self->{pos}){
		################   紫微   ####################  
		if($k eq "紫微"){
		$res->{$k}->{"main"} .= qq|
		    容貌：尊嚴厚重、氣質端莊。

		    性格：忠厚老成、謙恭耿直。氣質雖高、易受影響。

		    人格類型：領導型 (領導力)。

		    個性特質：領導、自大、孤傲、霸氣 、尊貴、孝順、無奈的誘惑、不易聽勸、固執的。很有效率的帶領團隊達成任務，並使其它人接受其想法。

		    愛情：氣度恢弘 。

		    優點：慈愛威嚴，君臨天下，求知慾盛，好勝心強，厚實穩重，不疾不徐，自愛自重，重視品質  踏實 有原則 講求方法 講求事實 充滿自信 分析 周全 善於盤算 重視氣勢 自尊心強。
		    缺點：剛愎自用，眼高手低，虛榮心重，佔有慾強，自負任性，發號施令 缺乏想像力 固執 辛苦勞神 受資料所限 剛愎自用 挑剔 古版 吝嗇 虛榮心重 過於高傲。

		    紫微為＂帝君＂，有降煞、制煞的能力。主工作事業，為解災厄、可延長壽命。是領袖人物，體面高貴，有統御能力，而且也是能夠獨當一面的人。有豐富的生命力，優越感榮譽心及偉大的使命感。喜歡發號司令，支配別人。也很有事業慾，企圖心強盛，有時顯得很固執倔強。主觀及自尊心較強，深沉內斂好面子，不習慣求助別人，富有豐富的生命力，遇困境皆能逆來順受，有時候也會感到孤獨。喜奉承，耳根子太軟。好面子，重視排場。主權威、顯像高貴，難免略有高傲之氣，且對事業靈動力較強。紫微一定要得＂群臣拱照＂始為高格，如孤星單守是為孤君，則無法施展身手。因此，單單一顆紫微星是不能發揮開疆闢土的作為。群臣為府相、輔弼、曲昌、魁鉞。最喜左輔、右弼來輔助，所以沒有隨從則性急躁。最怕天空、地劫。雖有惻隱之心能包融別人犯錯的雅量，為人敦厚性情倔強，舉止落落大方彬彬有禮，有長者之風範，但應防色難，容易受到感情傷害。自負、猜疑心重、善變、待人接物稍嫌表面化、主觀意識太強，也是其缺點。基本上的財運都不錯，能收能放，不過在過程中充滿了挑戰性。
		  |;


		  $res->{$k}->{"main"} .= qq | 對人謙恭有禮，官祿之主。

具有某種特殊專長之潛能。精神上有孤獨感，晚年愈明顯，尤以獨坐為甚。子女少或聚少離多，或身體不佳，或緣弱。婦女流產、難產之機會較大。

身態：中高身材，面瘦長，略帶圓形，面色紫微星紅或黃白色，年老時面帶棕紫色。氣質優雅，形貌厚重，態度從容，腰背肥滿。
個性：為人忠厚老實，聰明靈敏，志氣高傲，性情倔強且豪爽但多心性不定。對任何的事物都具有非常強烈的好奇心，喜歡學習新的事物，但是由於缺乏耐心，一經挫折或者某些原因，往往半途而廢，會讓人有種只為求得虛名的感覺。謙恭耿直，實則謙恭有餘，耳根較軟，善變且多疑，易受他人影響。有著強烈自尊心及優越感，不喜歡受到別人的約束，也較不喜歡屈服於別人的領導之下，所以內心因此也有著一種孤獨感。
		  |;

		  ####＊ 紫微居子午，科權祿照最為奇。

#       print "xxxx". Dumper( $self->has_sixghost star=>$k ));
		  
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
		  
		  if($self->born(  time=>["子", "午"] )  && $self->has_huaji( star=>$k, stars=>["科", "權", "祿"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|奇命。   |;
		  }		

		  ####＊ 紫微守命丑宮，前有吉曜來呼號，必當大權之職。

		  if($self->born(  time=>["丑"] )  && $self->has_jiagong(  stars=>@sixlucky ) ){
		       push @{$res->{$k}->{"additional"} },qq|必當大權之職。   |;

		  }
	      
		  ###＊ 紫微居午，無羊陀，甲丁己生人，位至公卿。

		   if($self->born(  time=>["午","甲","丁","己"] )  && !$self->has_stars(  stars=>["擎羊","陀羅"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|位至公卿。  |;

		    }

		    ###＊ 紫微男亥女寅宮，壬甲生人富貴同。

		     if(($self->born(  time=>["亥"] )  && $you->{sex} eq 0  )  || ($self->born(  time=>["寅"])  && $you->{sex} eq 1  )){
			if($self->born(  time=>["壬","甲"] )    ){
			    push @{$res->{$k}->{"additional"} },qq|富貴同。  |;
			}
		    }

		    ####＊ 紫微居卯酉，遇劫空四煞，多為脫俗僧人。


		    if($self->born(  time=>["卯","酉"] )    ){
			    if($self->has_sixghost ( ) ){
				push @{$res->{$k}->{"additional"} },qq|多為脫俗僧人。		|;
			    }
		      }

		  ####＊ 紫微無輔弼同行，則為孤君，美中不足。,

		    if(! $self->has_stars(  stars=>["左輔","右弼"]   )){
		      push @{$res->{$k}->{"additional"} },qq|為孤君，美中不足。		|;
		  }

		  ####＊ 紫微遇凶星，雖獲吉而無道。

		  ###凶星　　中天17兇星：天空、地劫、地空、天刑、天姚、天傷、天使、天虛、天哭、孤辰、寡宿、截空、旬空、蜚廉、破碎、天月、陰煞。 ２、兇星惡星類：貪、巨、廉、破、殺、羊、陀、火、鈴、化忌，中天17兇星，博士十二星中的小耗、飛廉、病符、大耗、伏兵、官符，永生十二星中的沐浴、衰、病、死、墓、絕。
		  
		#  print Dumper( $self->has_stars(  stars=>("天空","地劫","地空","天刑","天姚","天傷","天使","天虛","天哭","孤辰","寡宿","截空", "旬空","蜚廉","破碎","天月","陰煞","貪狼","巨門","廉貞","七殺","擎羊","破軍","陀羅","火星","鈴星","陰煞") ));
		  
		 # print Dumper( $self->has_stars(  stars=>["左輔","右弼"]   ));
		  
		  if( $self->has_stars(  stars=>["天空","地劫","地空","天刑","天姚","天傷","天使","天虛","天哭","孤辰","寡宿","截空","旬空","蜚廉","破碎","天月","陰煞","貪狼","巨門","廉貞","七殺","擎羊","破軍","陀羅","火星","鈴星","陰煞"]  ||  $self->has_huaji( star=>$k, stars=>["忌"] )  )){

	
		      push @{$res->{$k}->{"additional"} },qq|雖獲吉而無道。		|;

		  }

		  ######＊ 紫微天府，全依輔弼之功。
		  if( $self->has_stars(  stars=>["天府"]) ){
		      push @{$res->{$k}->{"additional"} },qq|全依輔弼之功。		|;

		  }

		  ######＊ 紫府同宮，終身福厚。
		  ####＊ 紫府同宮，無煞湊，甲生人享福終身。

		  if( $self->has_stars(  stars=>["天同"]) ){

			    if(!$self->has_sixghost ( ) ){

				 if($you->{gong_gan}->{$self->{pos}}=~ /甲/){
				
					push @{$res->{$k}->{"additional"} },qq|終身福厚。	|;
				}
			    }
		  }



		# 
		# ＊ 紫府朝垣，食祿萬鐘。
		# ＊ 紫府朝垣活祿逢，終身福厚至三公。
		# ＊ 紫府日月居旺地，斷定公侯器。
		#＊ 紫府夾命為貴格。
	        # # ＊ 紫微居財帛，更兼化祿富奢翁。或遇祿存亦可。
		# 
		# 
	      # # ＊ 大小限遇紫微星多能稱心如意。
  	      # # ＊ 運衰限衰，喜紫微之解兇惡。

		# # ＊ 紫微代表最高級、官貴。
		push @{$res->{$k}->{"additional"} },qq|代表最高級、官貴。	|;
		# # ＊ 紫微為北斗帝星、是事業宮主，當它位居事業宮時為得位，力量最強。



		  #####＊ 紫微與天府、左右、昌曲、祿馬三合，極吉，食祿千鐘，巨富大貴。

		  if( $self->has_shanhe(  stars=>["天府","左輔","右弼","祿存","天馬","文昌","文曲"]) ){

	      				push @{$res->{$k}->{"additional"} },qq|極吉，食祿千鐘，巨富大貴。	|;

		  }
  
		  #####＊ 紫微貪狼同宮於卯酉，不忠不義，暱近奸人。

		   if( $self->has_stars(  stars=>["貪狼"])  && $self->born(  time=>["卯","酉"] )   ){
	      				push @{$res->{$k}->{"additional"} },qq|不忠不義，暱近奸人。	|;

		    }
		  
		    #######＊ 紫微貪狼為至淫，男女邪淫。
		    #######＊ 女命，紫微與貪狼同宮，男女邪淫。

		   if($self->has_stars(  stars=>["貪狼"])  ){
	      				push @{$res->{$k}->{"additional"} },qq|男女邪淫。	|;

		    }

		    #######＊ 紫微守命，天相左右來夾拱，為君臣慶會，有治國經邦之才。
		   if( $self->has_jiagong(  stars=>["天相","左輔","右弼"])   ){
	      				push @{$res->{$k}->{"additional"} },qq|為君臣慶會，有治國經邦之才。	|;

		    }
		    
		    #######＊ 紫微七殺化權，反作禎祥。
		    if( $self->has_stars(  stars=>["七殺"])   && $self->has_huaji( star=>$k, stars=>["權"] )  ){
	      				push @{$res->{$k}->{"additional"} },qq|反作禎祥。	|;

		    }

		    #####＊ 紫微七殺加空亡，虛名受蔭。
		    if(  $self->has_stars(  stars=>["七殺","截空"])   ){
	      				push @{$res->{$k}->{"additional"} },qq|虛名受蔭。	|;

		    }

		     ####＊ 紫微七殺同宮會四煞，不貴，孤獨、刑傷。

		    if ($self->has_stars(  stars=>["七殺"])   && $self->has_fourghost()  ){
	      				push @{$res->{$k}->{"additional"} },qq|不貴，孤獨、刑傷。	|;

		    }

		    ####### 紫破命臨於丑未，再加吉曜，富貴堪期。
		     if( $self->has_stars(  stars=>["破軍","左輔","右弼","文曲","天鉞","文昌","天馬","天魁","祿存"])   && $self->born(  time=>["丑","未"] )   ){
	      				push @{$res->{$k}->{"additional"} },qq|富貴堪期。	|;

		      }
		      ###########＊ 紫微破軍，無左右，無吉曜，兇惡胥吏之徒。
		    if(  $self->has_stars(  stars=>["破軍"])   &&   !$self->has_stars(  stars=>["左輔","右弼","文曲","天鉞","文昌","天馬","天魁","祿存"]) ){
	      				push @{$res->{$k}->{"additional"} },qq|兇惡胥吏之徒。	|;

		      }

		      #####＊ 紫微辰戌遇破軍，富而不貴有虛名。

		     if( $self->has_stars(  stars=>["破軍"])    && $self->born(  time=>["辰","戌"] )   ){
	      				push @{$res->{$k}->{"additional"} },qq|富而不貴有虛名。君臣不義。	|;

		      }

		      ##########＊ 紫微遇破軍在辰戌丑未**四墓宮，主為臣不忠，為子不孝。
		     if($self->has_stars(  stars=>["破軍"])   && $self->born(  time=>["辰","戌","丑","未"] ) ){
	      				push @{$res->{$k}->{"additional"} },qq|主為臣不忠，為子不孝。	|;

		      }

		    ######＊ 紫微昌曲，富貴堪期。

		     if($self->has_stars(  stars=>["文昌","文曲"])    ){
	      				push @{$res->{$k}->{"additional"} },qq|富貴堪期。	|;

		      }

		      ######＊ 紫微輔弼同宮，一呼百諾，居上品。
		      # # ＊ 輔弼夾帝為上品，桃花犯主為至淫。(身命紫微與貪狼同宮，男女邪淫，奸詐巧語。得輔弼夾帝，貪狼受制，則不拘此論)

		     if( $self->has_stars(  stars=>["左輔","右弼"])  ){
	      				push @{$res->{$k}->{"additional"} },qq|一呼百諾，居上品。	|;

				if( $self->has_stars(  stars=>["貪狼"])  ){
	      				push @{$res->{$k}->{"additional"} },qq|淫受制	|;

				}

		      }

		      # # ＊ 紫微祿存同宮，貴不可言。
		     if(  $self->has_stars(  stars=>["祿存"])   ){
	      				push @{$res->{$k}->{"additional"} },qq|貴不可言。	|;

		      }

		      # # ＊ 紫微與諸煞同宮，諸吉合照，君子在野，小人在位，主人奸詐假善。
		      if(  $self->has_sixghost()  &&   $self->has_shanhe(  stars=>["祿存","文昌","文曲","左輔","右弼","天魁","天鉞","天馬"])  ){	
		      
		      
	      				push @{$res->{$k}->{"additional"} },qq|君子在野，小人在位，主人奸詐假善。	|;

		      }
		      # # ＊ 紫微權祿遇羊陀，雖獲吉而無道，主為人心術不正。
		     if(  $self->has_stars(  stars=>["擎羊","陀羅"])   &&  $self->has_huaji( star=>$k, stars=>["權","祿"] ) ){
	      				push @{$res->{$k}->{"additional"} },qq|雖獲吉而無道，主為人心術不正。|;

		      }

		      # # ＊ 紫微遇武曲破軍羊陀，欺公禍亂，只宜經商。
		      if($self->has_stars(  stars=>["擎羊","陀羅","武曲","破軍"])    ){
	      				push @{$res->{$k}->{"additional"} },qq|欺公禍亂，只宜經商。|;

			}
		      

		      # # ＊ 女命紫微在寅午申宮，吉貴美，旺夫益子。
		      if( $you->{sex} eq 1 ){
			    if ($self->born(  time=>["寅","午","申"] ) ){
	      				push @{$res->{$k}->{"additional"} },qq|吉貴美，旺夫益子。|;

			      }

		      # # ＊ 女命紫微在子午酉及巳亥，加四煞，美玉瑕玷，日後不美。

			    if ($self->born(  time=>["子","午","酉","巳","亥"] )  && $self->has_fourghost() ){

	      				push @{$res->{$k}->{"additional"} },qq|美玉瑕玷，日後不美。|;
				    

			      }
		      }

		      # # ＊ 紫微化科：適合學術研究，解厄力強。
		    if($self->has_huaji( star=>$k, stars=>["科"]  ) ){
			  push @{$res->{$k}->{"additional"} },qq|適合學術研究，解厄力強。|;
		    }

		      # # ＊ 紫微在命宮能表現出大方高貴的舉止，氣派、威儀，就算會齊火星、鈴星、擎 羊、陀羅也能自重自愛。
		      # # ＊ 紫微在命宮的人重名，宜研習專門能力或技術以防有名無實。
		      push @{$res->{$k}->{"additional"} },qq|能表現出大方高貴的舉止，氣派、威儀。能自重自愛。人重名，宜研習專門能力或技術以防有名無實。 |;

		      # # ＊ 紫微在命宮的男性聰明、不隨便低頭、讓人有信賴感。
		      if( $you->{sex} eq 0  ){
			  push @{$res->{$k}->{"additional"} },qq|聰明、不隨便低頭、讓人有信賴感。|;

		      }

		      # # ＊ 紫微加會左輔、右弼，有管理能力、有名望地位、社交能力強、有貴人助。
		    if( $self->has_jiahui(stars=>["左輔" ,"右弼"] )  ){
			  push @{$res->{$k}->{"additional"} },qq|有管理能力、有名望地位、社交能力強、有貴人助。|;

		    }

		      # # ＊ 紫微加會文昌、文曲：易有才藝及名氣、高學歷。
		    if( $self->has_jiahui(stars=>["文昌" ,"文曲"] )  ){
			  push @{$res->{$k}->{"additional"} },qq|易有才藝及名氣、高學歷。|;

		    }		    
		      # # ＊ 紫微加會天魁、天鉞：逢凶有貴人相助，一生機會較多。 
		    if( $self->has_jiahui(stars=>["天魁" ,"天鉞"] )  ){
			  push @{$res->{$k}->{"additional"} },qq|逢凶有貴人相助，一生機會較多。 |; 

		    }	
		      # # ＊ 紫微化權：權利慾大，小心不得人緣。 
		    if($self->has_huaji( star=>$k, stars=>["權"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|權利慾大，小心不得人緣。|;
		    }
		      # # ＊ 紫微加會科、權、祿：化祿增財祿；化權增權利、管理能力；化科增才學及名氣，一生多有意外機運。 
		      
		    if($self->has_jiahui_huaji( star=>$k, stars=>["祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|增財祿|;
		    }	    
		    if($self->has_jiahui_huaji( star=>$k, stars=>["權"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|增權利、管理能力|;
		    }	
		    if($self->has_jiahui_huaji( star=>$k, stars=>["科"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|才學及名氣，一生多有意外機運。 |;
		    }	


		      # # ＊ 紫微加會火星或鈴星：能加強紫微的勇猛戰鬥力。 
		    if($self->has_stars(  stars=>["火星","鈴星"])    ){
	      				push @{$res->{$k}->{"additional"} },qq|能加強勇猛戰鬥力。 |;

			}
		            	      
		      # # ＊ 紫微加會地空、地劫：多有出世尋找真理的精神，能體會哲理及宗教情操但易有空虛感且花費多。 
		    if($self->has_stars(  stars=>["地空","地劫"])    ){
	      				push @{$res->{$k}->{"additional"} },qq|多有出世尋找真理的精神，能體會哲理及宗教情操但易有空虛感且花費多。  |;

			}
		      # # ＊ 紫微加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌主勞祿。 
		    if($self->has_stars(  stars=>["地空","地劫","火星","擎羊","陀羅","鈴星"])   &&  $self->has_huaji( star=>$k, stars=>["忌"] ) ){
	      				push @{$res->{$k}->{"additional"} },qq|主勞祿。 |;

			}		      
		      # # ＊ 紫微無左輔、右弼，削減了管理的能力，也容易有財來財去的現象，比較辛勞。
		    if(!$self->has_stars(  stars=>["左輔","右弼"])    ){
	      				push @{$res->{$k}->{"additional"} },qq|削減了管理的能力，也容易有財來財去的現象，比較辛勞。  |;

			}




		  ####--------------------------####
		  push @{$res->{$k}->{"additional"} },qq| 對人謙恭有禮，官祿之主。
		      具有某種特殊專長之潛能。精神上有孤獨感，晚年愈明顯，尤以獨坐為甚。子女少或聚少離多，或身體不佳，或緣弱。婦女流產、難產之機會較大。
		      身態：中高身材，面瘦長，略帶圓形，面色紫微星紅或黃白色，年老時面帶棕紫色。氣質優雅，形貌厚重，態度從容，腰背肥滿。
		      個性：為人忠厚老實，聰明靈敏，志氣高傲，性情倔強且豪爽但多心性不定。對任何的事物都具有非常強烈的好奇心，喜歡學習新的事物，但是由於缺乏耐心，一經挫折或者某些原因，往往半途而廢，會讓人有種只為求得虛名的感覺。謙恭耿直，實則謙恭有餘，耳根較軟，善變且多疑，易受他人影響。有著強烈自尊心及優越感，不喜歡受到別人的約束，也較不喜歡屈服於別人的領導之下，所以內心因此也有著一種孤獨感。
		      		|;

		      		
		  # 命宮的宮位是「辰、戌」，一生波折多，多半可富但不能大貴；或者可貴而不能大富，富貴無法兼得。

		  if($self->born(  time=>["辰","戌"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|一生波折多，多半可富但不能大貴；或者可貴而不能大富，富貴無法兼得。|;
		  }

		    # 同一命宮中有其他星宿時：
		  # 命宮有：擎羊、陀羅、火星、鈴星，普通經商。
		  if( $self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星 "]) ){
		       push @{$res->{$k}->{"additional"} },qq|普通經商|;

		  }

		  # 命宮有：六吉星宿，也能發財，但是口舌事非甚多，易發生麻煩的糾紛。
		  if( $self->has_sixlucky()){
		       push @{$res->{$k}->{"additional"} },qq| 能發財，但是口舌事非甚多，易發生麻煩的糾紛。|;

		  }	

		  # 命宮有：擎羊星，且擎羊的旺度為陷，常常會有口舌、是非等遭遇發生。
		  if( $self->has_stars(  stars=>["擎羊"]) && $you->{ziwei}->{"擎羊"}->{bright} eq "陷"){
		       push @{$res->{$k}->{"additional"} },qq| 能發財，但是口舌事非甚多，易發生麻煩的糾紛。|;

		   }

	      }
		################   天機   ####################  
		if($k eq "天機"){
		
		   $res->{$k}->{"main"}.= qq|
		    容貌：眉細眼銳、額寬顎狹。

		    性格：性急心慈、機謀多變。智慧雖高、趨於幻想。

		    人格類型：支援型 (分析問題能力)。

		    個性特質：機智、聰明、敏感、觀察、反應快 、智慧、清高、與宗教有緣、居家是非多、晚發、不易經商、第二匹天馬。有效地解釋、找尋及有關解決問題的一些資料。

		    愛情：敏銳透徹 。

		    優點：分析研究，思慮周詳，反應敏捷，服務貢獻，待人親切，學有專長，善體人意，喜歡團體活動 思慮周密 追求卓越 為人著想 謙虛 忠誠 理想化 樂於助人 善於回應 接受性強。
		    缺點：神經過敏，理想太高，煩躁倔強，不易認錯，幻想太多，心神不寧，精神壓力太重，受困人情面子，猜疑妒忌，因小失大 完美主義 否定自己  自貶、缺乏自信 愚忠 不切實際 過度關心 過度投入 被動 屈服。
		
		 天機為＂謀臣＂，與五術緣深。乃智慧、仁善、計數之星，是奔動之宿。智慮過人，創意特多，思考及行動都很敏捷，對新鮮事物及新知識有強烈的好奇心，喜歡投機冒險，創造發明。聰明機警好動好學，而且心地善良，勤勞認真，處事有條理，冷靜有魄力，反應靈敏、口才佳、善策劃、有機謀，宜以幕僚與經理企劃人才為主要發展之專長。雖喜歡學習各種技巧及新鮮的事物，卻易有博而不精的現象。深懂充實自己，待價而沽的哲學。聰明，但容易鑽牛角尖，眉頭較緊。宜從商不宜從官。最適合為人服務，甚宜專門技術。雖有通達靈變之智，富機略善策劃，但難免心慈而性急，又因心地慈善，比較不好事，也比較怕事，膽識猶嫌不足。此外，也主人生變動較大，多愁善感。喜化權增加其穩定。最喜文昌、文曲來會。天機星最怕化忌，主"頭殼壞了"，愛鑽牛角尖，易患有神經質，想太多反而對事情裹足不前。天機星本身的儲蓄能力並不太好，這是因為天機的想法有時太過天馬行空的緣故。感情則很容易受到外向活潑、熱情有自己目標、理想的異性所吸引。
		|;
		
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }		
		# #  ＊ 天機與天梁、左右、昌曲會合，文為清顯，武為忠良。
		  if( $self->has_jiahui(  stars=>["天梁","左輔","右弼","文昌" ,"文曲"]) ){
		       push @{$res->{$k}->{"additional"} },qq| 文為清顯，武為忠良。|;

		   }
		
		# # ＊ 天機在丑未陷地守命，遇四煞衝破，下局，宜經商習藝。
		
		if ($self->born(  time=>["丑","未"] ) && $you->{ziwei}->{$k}->{bright} eq "陷"  && $self->has_fourghost() ){

			  push @{$res->{$k}->{"additional"} },qq|宜經商習藝。|;
		      

		}

			      
			      

		# # ＊ 機月同梁作吏人。（命在寅申方論。此四星必三合曲全，方准刀筆功名可就。加化忌下格，若無四星，三者難成）
		  if( $self->has_stars(  stars=>["天梁","太陰","天同","天梁" ]) ){
		       push @{$res->{$k}->{"additional"} },qq| 作吏人。|;
			  if ($self->born(  time=>["寅","申"] )  && $self->has_shanhe(  stars=>["天梁","太陰","天同","天梁" ]) ){

				    push @{$res->{$k}->{"additional"} },qq|方准刀筆功名可就.|;
				    

				   
			  }
		   }else{
		   		 if( $self->has_huaji( star=>$k, stars=>["忌"] )){
				    	push @{$res->{$k}->{"additional"} },qq|三者難成|;

				    }
		   }
				
		# # ＊ 天機與太陰同于寅申，難免跋涉他鄉。
		if ($self->born(  time=>["寅","申"] ) && $self->has_stars(  stars=>["太陰" ])  ){

			  push @{$res->{$k}->{"additional"} },qq|難免跋涉他鄉。|;
		      

		}		
		# # ＊ 天機與巨門同於卯酉，必退祖而自興。
		if ($self->born(  time=>["卯","酉"] ) && $self->has_stars(  stars=>["巨門" ])  ){

			  push @{$res->{$k}->{"additional"} },qq|必退祖而自興。|;
		      

		}		
		# # ＊ 巨機酉上化吉者，縱遇財官也不榮。
		if ($self->born(  time=>["酉"] )  ){

			  push @{$res->{$k}->{"additional"} },qq|縱遇財官也不榮|;
		      

		}

		# # ＊ 機梁會合善談兵，居戌亦為美論。（孟子遷移戌宮，有機梁。為機梁加會格）
		if ($self->has_stars(  stars=>["天梁" ])  ){
			  push @{$res->{$k}->{"additional"} },qq|善談兵|;
		    if ($self->born(  time=>["亦"] )  ){
			  push @{$res->{$k}->{"additional"} },qq|亦為美論|;

		  }

		}		

		# # ＊ 機梁同在辰戌宮守命，加吉曜，富貴慈祥。
		# # ＊ 機梁同在辰戌宮守命，逢空亡，偏宜僧道。
		if ($self->has_stars(  stars=>["天梁" ])  && $self->born(  time=>["辰","戌"] )   ){
			  push @{$res->{$k}->{"additional"} },qq|逢空亡，偏宜僧道。|;

			if($self->has_sixlucky()){
			  push @{$res->{$k}->{"additional"} },qq|富貴慈祥。|;
			}


		}		
	
		# # ＊ 機梁加惡煞同宮，狗偷鼠竊。
		if ($self->has_stars(  stars=>["天梁" ]) && $self->has_sixghost()    ){
			  push @{$res->{$k}->{"additional"} },qq|狗偷鼠竊。|;


		}

		if($you->{sex} eq 1){
		# # ＊ 女命，天機入廟，性剛機巧，有機柄，持家，旺夫益子，有福有壽。
		  if($you->{ziwei}->{"天機"}->{bright} eq "廟" ){
			  push @{$res->{$k}->{"additional"} },qq|性剛機巧，有機柄，持家，旺夫益子，有福有壽。|;

		  }
  
		# # ＊ 女命，天機在寅申卯酉守命，雖有富貴不免淫佚，寅申守照，福不全美。
		    if ($self->born(  time=>["寅","申","卯","酉"] )  ){
			  push @{$res->{$k}->{"additional"} },qq|雖有富貴不免淫佚，寅申守照，福不全美。|;

		  }
		# # ＊ 女命，天機與太陰、巨門、天梁同宮，遇羊陀火鈴沖合，淫賤、偏房、娼婢，否則傷夫克子。
		  if ($self->has_stars(  stars=>["太陰","巨門","天梁" ]) && $self->has_fourghost() ){
			  push @{$res->{$k}->{"additional"} },qq|淫賤、偏房、娼婢，否則傷夫克子。|;

		  }
		}
		# # ＊ 天機代表聰明、善變。
		# # ＊ 天機宜鑽研學問成為專家學者。
		 push @{$res->{$k}->{"additional"} },qq|聰明、善變。鑽研學問成為專家學者。|;

		# # ＊ 天機加會左輔、右弼：有智慧能力，社交能力強，有貴人。
		if ($self->has_stars(  stars=>["左輔","右弼" ])  ){
		 push @{$res->{$k}->{"additional"} },qq|有智慧能力，社交能力強，有貴人。|;

		}
		# # ＊ 天機加會地空、地劫：財來財去，對宗教有興趣。
		if ($self->has_stars(  stars=>["地空","地劫" ])  ){
		 push @{$res->{$k}->{"additional"} },qq|財來財去，對宗教有興趣。|;

		}		

		# # ＊ 天機加會文昌、文曲：易有才能，可成顧問、特助。
		if ($self->has_stars(  stars=>["文昌","文曲" ])  ){
		 push @{$res->{$k}->{"additional"} },qq|易有才能，可成顧問、特助。|;

		}		
		# # ＊ 天機加會天魁、天鉞：有貴人相助，機運佳。
		if ($self->has_stars(  stars=>["天魁","天鉞" ])  ){
		 push @{$res->{$k}->{"additional"} },qq|有貴人相助，機運佳。|;

		}		
		# # ＊ 天機化祿：業績佳，善於買賣，聰明理性。
	      if( $self->has_huaji( star=>$k, stars=>["祿"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|三者難成|;

		}		

		# # ＊ 天機化權：管理能力佳，聰明能幹。
	      if( $self->has_huaji( star=>$k, stars=>["權"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|管理能力佳，聰明能幹。|;

		}
		# # ＊ 天機化科：擅學術研究，聰明靈活。
	      if( $self->has_huaji( star=>$k, stars=>["科"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|擅學術研究，聰明靈活。|;

		}

		# # ＊ 天機化忌：思想特異或鑽牛角尖，勞心勞力。
	      if( $self->has_huaji( star=>$k, stars=>["忌"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|思想特異或鑽牛角尖，勞心勞力。|;

		}


		# # ＊ 天機加會火星或鈴星心思變動不定，脾氣暴燥，有技藝之人。
		    if( $self->has_jiahui(stars=>["火星" ] ) ||  $self->has_jiahui(stars=>["鈴星"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|心思變動不定，脾氣暴燥，有技藝之人。|;

		    }

		# # ＊ 天機加會擎羊或陀羅，有小聰明，易有意外，心意不定。
		    if( $self->has_jiahui(stars=>["擎羊" ] ) || $self->has_jiahui(stars=>["陀羅"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|有小聰明，易有意外，心意不定。|;

		    }		

		# # ＊ 天機加會火星、鈴星、擎羊、陀羅，地空，地劫，化忌會齊如果意志不堅，易患憂鬱症或結交損友。
		    if( $self->has_jiahui(stars=>["火星" ,"鈴星" ,"擎羊" ,"陀羅","地空","地劫"] ) &&  $self->has_jiahui_huaji(stars=>["忌"] )){
			  push @{$res->{$k}->{"additional"} },qq|如果意志不堅，易患憂鬱症或結交損友。|;
 
		    }		
		# # ＊ 天機加會科、權、祿：為人感性及理性，分析力強，一生機運佳。
		    if(   $self->has_jiahui_huaji(stars=>["科","權","祿"] )){
			  push @{$res->{$k}->{"additional"} },qq|為人感性及理性，分析力強，一生機運佳。|;

		    }	

		# # ＊ 大小限遇天機星事業多有變動。		
		# # 		
	        # # ＊ 天機巳亥逢，好飲、離宗、奸狡重。

		
		############--------------######
		   $res->{$k}->{"main"} .= qq| 做事有操守，達機變。
		      擅長于交涉、策劃、剖析，足智多謀，行事頗有條理，有設計創新的能力，想像力豐富，智商高，聰明，有經商賺錢的天份。參謀秘書人才，對事務具有多方面興趣。天生好酒量，但非嗜酒如狂。具運動潛能，並有機會接近運動、交通、運輸、旅遊。腦神經易衰弱。
		      身態：身材適中，不高不矮，聰明巧智，臉細長橢圓，面色青白，年老時略帶黃色。
		       個性：神經容易過敏或多愁善感，較有異性緣。性雖急，談吐卻斯文，字字經思考，才說出來。男性，機謀多變，多才多藝。
		      		|;
		      		
		      		
		  # 天機星的旺度為陷，或命宮有「巨門」時，身體瘦，中高身材。面長且瘦略帶圓形，亦有長圓形，心慈性急，好學好動。

		  if($you->{ziwei}->{"天機"}->{bright} eq "陷" ||  $self->has_stars(  stars=>["巨門"]) ){
		       push @{$res->{$k}->{"additional"} },qq|身體瘦，中高身材。面長且瘦略帶圓形，亦有長圓形，心慈性急，好學好動。|;
		   }

		  # 天機星的旺度為廟身長肥胖，最善談兵。
		  if($you->{ziwei}->{"天機"}->{bright} eq "廟"  ){
		       push @{$res->{$k}->{"additional"} },qq|身長肥胖，最善談兵。|;
		   }

		  # 同一命宮中有其他星宿時：
		  # 命宮有：天梁，口才好，善辯善談，性情極為敏感，能夠隨機應變。
		  if(  $self->has_stars(  stars=>["天梁"]) ){
		       push @{$res->{$k}->{"additional"} },qq|口才好，善辯善談，性情極為敏感，能夠隨機應變。|;
		  }
		  # 命宮有：太陰，有內材，有權術，並且較重情感。
		  if(  $self->has_stars(  stars=>["太陰"])){
		       push @{$res->{$k}->{"additional"} },qq|有內材，有權術，並且較重情感。|;
		  }


		  # 命宮有：六煞，經商為宜，但多變動。
		    ###六煞
		  if( $self->has_sixghost()){
		       push @{$res->{$k}->{"additional"} },qq|經商為宜，但多變動。;|;

		  }

		  # 命宮有：六吉星，身兼數職，或有專門技能，藝術成功之士。
		  ###六吉
		  if( $self->has_sixlucky()){
		       push @{$res->{$k}->{"additional"} },qq|身兼數職，或有專門技能，藝術成功之士。;|;

		  }	

		  # 命宮有：天梁，雖能發但不能長久，雖能貴徒負虛名。
		  if(  $self->has_stars(  stars=>["天梁"]) ){
		       push @{$res->{$k}->{"additional"} },qq|雖能發但不能長久，雖能貴徒負虛名。 |;
		  }

		  # 命宮有天梁、或命宮有天同、或命宮有太陰，宜在政府機關或在公眾事業中謀發展。
		  if(  $self->has_stars(  stars=>["天梁","天同","太陰"])){
		       push @{$res->{$k}->{"additional"} },qq|宜在政府機關或在公眾事業中謀發展。 |;
		  }

		  # 命宮有：文昌，文曲，宜於大眾文化事業中服務。
		  if( $self->has_stars(  stars=>["文昌","文曲"])  ){
		       push @{$res->{$k}->{"additional"} },qq|宜於大眾文化事業中服務。 |;
		  }

		  # 命宮有：太陰、或命宮有天梁、且身宮有貪狼，主人日夜奔忙、勞碌異常或有酒賭等嗜好。
		  if( $self->has_stars(  stars=>["太陰","天梁"]) && $self->has_stars(  stars=>["貪狼"])){
		       push @{$res->{$k}->{"additional"} },qq|主人日夜奔忙、勞碌異常或有酒賭等嗜好。 |;
		  }

		  # 命宮有：擎羊，陀羅，火星，鈴星，雖能富貴，但不能長久，多災多難，或落地後即他遷，或祀出，否則遭遇虛驚。
		  if($self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星"])  ){
		       push @{$res->{$k}->{"additional"} },qq|雖能富貴，但不能長久，多災多難，或落地後即他遷，或祀出，否則遭遇虛驚。|;

		  }

		  # 命宮有：巨門，多口舌。
		  if( $self->has_stars(  stars=>["巨門"]) ){
		       push @{$res->{$k}->{"additional"} },qq|多口舌。 |;
		  }

		  # 女性性情剛強，機巧聰明，助夫益子，持家有方，操持過丈夫。
		  if( $you->{sex} eq 1 ){
		       push @{$res->{$k}->{"additional"} },qq|性情剛強，機巧聰明，助夫益子，持家有方，操持過丈夫。|;
		  # 天機星為化忌時，多憂善慮，有刺激性，易受外界影響而起感觸，為異性又愛又恨的對象，是一朵有刺的玫瑰。
		      if($self->has_huaji( star=>$k, stars=>["忌"] )){
			   push @{$res->{$k}->{"additional"} },qq|多憂善慮，有刺激性，易受外界影響而起感觸，為異性又愛又恨的對象，是一朵有刺的玫瑰。|;
		      }
		  # 命宮有太陰，容貌美麗，富情感，善機對。		      		
		      if( $self->has_stars(  stars=>["太陰"]) ){
			   push @{$res->{$k}->{"additional"} },qq|容貌美麗，富情感，善機對。 |;
		      }

		  }



	      }

		################   太陽   ####################  
		if($k eq "太陽"){
# # 日生最宜，急公好義，為官祿主。
# # 擁有無私的意念，待人誠懇熱情，博愛、光明、好濟施、好面子、積極、主動。刑克陽性近親。女命對配偶時有埋怨及挑剔。易接近清高工作，如研究學術、考試、文藝、公職等。易患眼疾、腦神經衰弱、心臟、血壓、糖尿等疾病。
# # 身態：人面色紅潤，相貌方圓，體格雄壯，雄氣有威，形貌堂堂。太陽的旺度為陷，中矮身型。
# # 個性：說話過於直接，毫不保留，所以有時難免讓人受不了，而得罪他人。並且歡爭論，容易生氣。做事積極主動，外交場合表現大方，喜歡參加活動，結交朋友。個性坦率不計得失，脾氣稍急燥。

		   $res->{$k}->{"main"}.=  qq|
 容貌：圓滿雄壯、堂堂正正。

性格：凜性聰明、慈愛寬大。魄力雖足、難免浮華。

人格類型：支援型 (計劃與組織力)。

個性特質：正直、熱情、豪爽、志高氣傲、無私、理想化 、光明正大、愚忠、富貴、作福他人、剛烈直爽、無私心。有效地進行、安排相關事物，且能以有系統及適當的行為來進行工作。

愛情：熱情積極 。

優點：熱情積極，坦率直接，心地寬宏，不計仇怨，精力十足，雄辯滔滔。
缺點：操心操勞，心浮氣躁，過份熱心，容易招搖，逞強好勝，獨攬責任，喜歡據理力爭，一生難免辛勞。

 具使命感，優越感，有榮譽心，慈悲心，熱忱、不畏辛苦困難，有魄力果決！不願墨守成規。外表亮麗，男俊女美，輪廓明顯。寬大明朗的心志有愛心，多能忍讓牽就別人。犧牲自己，照亮他人，適合服務業以及宗教。不論成就大小與否，都難免辛勤勞碌！太陽也象徵光明，博愛，權貴，與熱力(創造)，無論男女命皆主個性慈愛、慷慨大方、好濟施！性情灑脫又性格！喜廣結善緣，樂於服務大眾，但由於過份熱心容易招搖，精神壓力甚重。有領導潛能，具開創的精神及能力！唯喜歡支配及指揮他人，不喜受約束，好勝心太強，喜歡據理力爭，自我意識高。太陽星主精神之靈動力，也主官祿事業，功名多於財富。六親而言主父星、夫星、子星，亦可類化為機關、政界、眼睛、頭腦。最喜化祿。白天生的人較好，夜晚生人則較差一點。忌入戌亥子丑宮，喜入寅卯辰巳午宮。太陽星總是有著一些遠大的階段性目標，而這往往要耗去他不少的心力與金錢，因此，在消費觀算說是最沒有數字概念的。此外，個性較不拘小節的他們是最易被秀氣、好心腸、保守的異性吸引。
|;
#        具使命感，優越感，有榮譽心，慈悲心，熱忱、不畏辛苦困難，有魄力果決！不願墨守成規。外表亮麗，男俊女美，輪廓明顯。寬大明朗的心志有愛心，多能忍讓牽就別人。犧牲自己，照亮他人，適合服務業以及宗教。不論成就大小與否，都難免辛勤勞碌！太陽也象徵光明，博愛，權貴，與熱力(創造)，無論男女命皆主個性慈愛、慷慨大方、好濟施！性情灑脫又性格！喜廣結善緣，樂於服務大眾，但由於過份熱心容易招搖，精神壓力甚重。有領導潛能，具開創的精神及能力！唯喜歡支配及指揮他人，不喜受約束，好勝心太強，喜歡據理力爭，自我意識高。太陽星主精神之靈動力，也主官祿事業，功名多於財富。六親而言主父星、夫星、子星，亦可類化為機關、政界、眼睛、頭腦。最喜化祿。白天生的人較好，夜晚生人則較差一點。忌入戌亥子丑宮，喜入寅卯辰巳午宮。太陽星總是有著一些遠大的階段性目標，而這往往要耗去他不少的心力與金錢，因此，在消費觀算說是最沒有數字概念的。此外，個性較不拘小節的他們是最易被秀氣、好心腸、保守的異性吸引。

# ＊ 太陽守命於卯辰巳午，見諸吉守照，必大貴；見諸凶，亦為公卿門下士。
		  if($self->born(  time=>["卯","辰","巳","午"]  )){
		       push @{$res->{$k}->{"additional"} },qq|見諸吉守照，必大貴；見諸凶，亦為公卿門下士|;
		  }
# ＊ 太陽守命于未申，為人先勤後惰。
		  if($self->born(  time=>["未","申"]  )){
		       push @{$res->{$k}->{"additional"} },qq|為人先勤後惰。|;
		  }
# ＊ 太陽守命於酉，貴而不顯，秀而不實。
		  if($self->born(  time=>["酉"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|貴而不顯，秀而不實。|;
		  }

# ＊ 太陽守命，日生廟旺，夜生陷。
# ＊ 太陽守命，落陷，勞心費力，雖化權祿亦凶，官祿不顯，先勤後惰，成敗不一，但出外離祖可吉。
		  if($you->{ziwei}->{"太陽"}->{bright} eq "陷"){
		       push @{$res->{$k}->{"additional"} },qq|勞心費力。|;

		      if( $self->has_huaji( star=>$k, stars=>["權","祿"] ) ){
			    push @{$res->{$k}->{"additional"} },qq|官祿不顯，先勤後惰，成敗不一，但出外離祖可吉。|;

			}

		   }

# ＊ 太陽守命，落陷，加凶煞帶疾，化忌目疾。
		  if($you->{ziwei}->{"太陽"}->{bright} eq "陷" && $self->has_sixghost()  ){
			  push @{$res->{$k}->{"additional"} },qq|帶疾。|;

		      if( $self->has_huaji( star=>$k, stars=>["忌"] ) ){
			    push @{$res->{$k}->{"additional"} },qq|目疾。|;

			}

		  }
# ＊ 太陽守命於卯地，晝生人富貴榮華。（為日照雷門格）
		  if($self->born(  time=>["卯"]  )){
		       push @{$res->{$k}->{"additional"} },qq|晝生人富貴榮華。|;
		  }
# ＊ 太陽居午，謂之日麗中天，有專權之貴，敵國之富。
		  if($self->born(  time=>["午"]  )){
		       push @{$res->{$k}->{"additional"} },qq|謂之日麗中天，有專權之貴，敵國之富。|;
		  }
# ＊ 太陽居午，庚辛丁己生人富貴雙全。
		  if($self->born(  time=>["午"]) && $self->born(  time=>["庚","辛","丁","己"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|富貴雙全。|;
		  }
# ＊ 太陽會文昌於官祿，皇殿朝班，富貴全美。
		  if( $self->has_stars(  stars=>["文昌"])  ){
		       push @{$res->{$k}->{"additional"} },qq|官祿，皇殿朝班，富貴全美。|;
		  }

# ＊ 太陽化忌，是非日有，目還傷。
		      if( $self->has_huaji( star=>$k, stars=>["忌"] ) ){
			    push @{$res->{$k}->{"additional"} },qq|是非日有，目還傷。|;

			}


# ＊ 日月夾命、夾財，加吉曜，不權則富。（加羊陀沖守，宜僧道）
		  if( $self->has_stars(  stars=>@sixlucky ) &&  $self->has_jiagong(  stars=>["太陽","太陰"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|不權則富。|;
			 if(  $self->has_stars(  stars=>["擎羊" ,"陀羅"]) ){
				push @{$res->{$k}->{"additional"} },qq|宜僧道。 
				|;
			  }
		  }

# ＊ 日月同未，安命丑，侯伯之材。（唯亦須化吉方佳。丙辛人吉）
		  if( $self->has_stars( pos=>$self->position(time=>["未"]), stars=>["太陰","太陽"])  && $self->born(  time=>["丑"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|侯伯之材。（唯亦須化吉方佳。丙辛人吉）|;
		  }

# ＊ 日月同丑，安命未，侯伯之材。（同上注解）
		  if( $self->has_stars( pos=>$self->position(time=>["丑"]), stars=>["太陰","太陽"])  && $self->born(  time=>["未"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|侯伯之材。（唯亦須化吉方佳。丙辛人吉）|;
		  }

#push @{$res->{$k}->{"additional"} },Dumper($self->position(time=>["未"]));

# ＊ 日巳月酉，安命丑，佐九重於堯殿。（為日月並明格，辛乙生人合格。丙生人主貴，丁生人主富。加四煞空劫平常）
		  if( $self->has_stars( pos=>$self->position(time=>["巳"]), stars=>["太陽"]) &&  $self->has_stars( pos=>$self->position(time=>["酉"]), stars=>["太陰"])  && $self->born(  time=>["丑"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|佐九重於堯殿。（為日月並明格，辛乙生人合格。丙生人主貴，丁生人主富。加四煞空劫平常）|;
		  }

# ＊ 日卯月亥，安命未，蟾宮折桂之榮。（為明珠出海格，主財官雙美）
		  if( $self->has_stars( pos=>$self->position(time=>["卯"]), stars=>["太陽"]) &&  $self->has_stars( pos=>$self->position(time=>["亥"]), stars=>["太陰"])  && $self->born(  time=>["未"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|蟾宮折桂之榮。（為明珠出海格，主財官雙美）|;
		  }
# ＊ 日辰月戌並爭耀，權祿非淺。（日安命辰宮，月戌宮對照。月安命戌宮，日辰宮對照）
		  if( $self->has_stars( pos=>$self->position(time=>["辰"]), stars=>["太陽"]) &&  $self->has_stars( pos=>$self->position(time=>["戌"]), stars=>["太陰"])  && $self->born(  time=>["辰"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|權祿非淺。（日安命辰宮，月戌宮對照。月安命戌宮，日辰宮對照）|;
		  }
# ＊ 日月科祿丑未中，定是方伯公。
		    #push @{$res->{$k}->{"additional"} },Dumper($self->has_huaji( star=>"太陰", stars=>["科","祿"]  ) );
		    if(($self->has_huaji( star=>$k, stars=>["科","祿"]  ) || $self->has_huaji( star=>"太陰", stars=>["科","祿"]) ) &&  $self->born(  time=>["丑","未"]) ){
			  push @{$res->{$k}->{"additional"} },qq|適合學術研究，解厄力強。|;
		    }


# ＊ 日居卯辰巳，月入酉戌亥，在此六宮安身命，早遂青雲之志。（亦宜見昌曲魁鉞）
		    if($self->born(  time=>["卯","辰","巳"]) &&  $self->born( pos=>$you->{ziwei}->{"太陰"}->{pos}, time=>["酉","戌","亥"]) ){
			  push @{$res->{$k}->{"additional"} },qq|早遂青雲之志。（亦宜見昌曲魁鉞）|;
		    }
# ＊ 日月守命於丑未，昌曲夾之貴且顯。
		      if( $self->has_stars(  stars=>["太陰"]) && $self->born(  time=>["丑","未"] )  &&  $self->has_jiagong(  stars=>["文昌","文曲"])    ){
			   push @{$res->{$k}->{"additional"} },qq|貴且顯。|;
		      }

# ＊ 日月會昌曲，出世榮華。
		      if( $self->has_stars(  stars=>["太陰"])  &&  $self->has_jiahui(  stars=>["文昌","文曲"])    ){
			   push @{$res->{$k}->{"additional"} },qq|出世榮華。|;
		      }
 
# ＊ 日月羊陀多克親。
		      if( $self->has_stars(  stars=>["太陰","擎羊" ,"陀羅"])) {   
			   push @{$res->{$k}->{"additional"} },qq|多克親。|;
		      }

# ＊ 太陽代表顯貴，博愛。
			   push @{$res->{$k}->{"additional"} },qq|顯貴，博愛。|;
# ＊ 太陽在寅卯辰已午等宮為廟旺，在未申失輝做事先勤後惰，在酉貴而不顯，秀而不實；在戍亥子丑為失輝。
		      if($self->born(  time=>["未","申"] ) ){
			   push @{$res->{$k}->{"additional"} },qq|做事先勤後惰。|;
		      }
		      if($self->born(  time=>["酉"] ) ){
			   push @{$res->{$k}->{"additional"} },qq|不顯，秀而不實。|;
		      }

# ＊ 太陽廟旺在命宮或身宮，事業人事必順利；太陽在失輝，父母緣薄，外地謀生，操心操勞，做事先勤後墮；男人不利父親（可能代溝分離），女人不利夫（可能事業不順或身體不佳）。（太陽在申酉戌亥子，乃為失輝。太陰在卯辰巳午未，乃為失輝）
		      if($you->{ziwei}->{"太陽"}->{bright} eq "廟" || $you->{ziwei}->{"太陽"}->{bright} eq "旺"   ){
			   push @{$res->{$k}->{"additional"} },qq|事業人事必順利；|;
			    if($self->born(  time=>["申","酉","戌","亥","子"] ) ){
				push @{$res->{$k}->{"additional"} },qq|為失輝。父母緣薄，外地謀生，操心操勞，做事先勤後墮；男人不利父親（可能代溝分離），女人不利夫（可能事業不順或身體不佳）。
				|;
			    }
			
		      }

# ＊ 太陽廟旺加會左輔、右弼，能說善辯，居領導地位，社交能力強，有貴人助。
		      if( ($you->{ziwei}->{"太陽"}->{bright} eq "廟" || $you->{ziwei}->{"太陽"}->{bright} eq "旺") && $self->has_jiahui(  stars=>["左輔","右弼"])     ){
			   push @{$res->{$k}->{"additional"} },qq|能說善辯，居領導地位，社交能力強，有貴人助。|;
		      }
# ＊ 太陽失輝加會左輔、右弼，有幽默感，和群，自助人助。（太陽在申酉戌亥子，乃為失輝。太陰在卯辰巳午未，乃為失輝）
		      if( $self->born(  time=>["申","酉","戌","亥","子"] ) && $self->has_jiahui(  stars=>["左輔","右弼"])     ){
			   push @{$res->{$k}->{"additional"} },qq|能有幽默感，和群，自助人助。|;
		      }

# ＊ 太陽化祿：利於專業的生意，主管階級。
		  if($self->has_huaji( star=>$k, stars=>["祿"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|利於專業的生意，主管階級。|;
		  }
# ＊ 太陽化權：好表現、剛強、頑固。
		  if($self->has_huaji( star=>$k, stars=>["權"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|好表現、剛強、頑固。|;
		  }
# ＊ 太陽化忌：太陽廟旺脾氣暴躁，易得罪人，太陽在失輝，脾氣暴躁生悶氣，學 習能力弱，口舌是非不斷，易受人看輕，事倍功半。（太陽在申酉戌亥子，乃為失輝。太陰在卯辰巳午未，乃為失輝）
		  if($self->has_huaji( star=>$k, stars=>["忌"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|陽廟旺脾氣暴躁，易得罪人，|;

			if( $self->born(  time=>["申","酉","戌","亥","子"] )) {
			   push @{$res->{$k}->{"additional"} },qq|脾氣暴躁生悶氣，學 習能力弱，口舌是非不斷，易受人看輕，事倍功半。|;
			}

		  }

# ＊ 太陽加會地空、地劫為財來財去為人好面子。
		  if( $self->has_jiahui(  stars=>["地空","地劫"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|為財來財去為人好面子。|;
		  }

# ＊ 太陽加會文昌、文曲、易有文才能可成學者，專家。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|易有文才能可成學者，專家。|;
		  }

# ＊ 太陽加會天魁、天鉞，好交友，逢凶有貴人相助。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|好交友，逢凶有貴人相助。|;
		  }
# ＊ 太陽廟旺加會科、權、祿，能力強，人緣佳，人固執。
		    if($self->has_jiahui_huaji( star=>$k, stars=>["科","權","祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|能力強，人緣佳，人固執。|;
		    }	 

# ＊ 太陽在失輝先名利雙收後易有名無實。 （太陽在申酉戌亥子，乃為失輝。太陰在卯辰巳午未，乃為失輝）
		    if($self->born(  time=>["申","酉","戌","亥","子"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|先名利雙收後易有名無實。|;
		    }	 

# ＊ 女命端正太陽星，早配賢夫信可憑。（太陽守命，居卯辰巳午，無煞加，旺夫益子。陷地平常）
# ＊ 女命太陽性格剛者宜嫁性情溫和者。 
 if( $you->{sex} eq 1){
			   push @{$res->{$k}->{"additional"} },qq| 女命太陽性格剛者宜嫁性情溫和者。 早配賢夫信可憑。|;
			if( ($you->{ziwei}->{"太陽"}->{bright} eq "陷")){
			      push @{$res->{$k}->{"additional"} },qq|平常。
				|;
			}elsif($self->born(  time=>["卯","辰","辰","巳","午"] ) && ! $self->has_sixghost()  ){
			      push @{$res->{$k}->{"additional"} },qq|旺夫益子。
				|;
			}	
		    
}
 # ＊ 日月在疾厄宮或命宮，逢空亡，必主腰駝目瞽。
		      if( $self->has_stars(  stars=>["太陰"])     ){
			   push @{$res->{$k}->{"additional"} },qq|逢空亡，必主腰駝目瞽。|;
		      }
# ＊ 太陽最怕在失輝不利事業，縱得富貴榮耀，也十分辛勞。
# ＊ 日月最嫌反背，乃為失輝。（太陽在申酉戌亥子，或夜生人，乃為失輝。太陰在卯辰巳午未，或晝生人，乃為失輝） 
		      if($self->born(  time=>["申","酉","戌","亥","子"] )){
			   push @{$res->{$k}->{"additional"} },qq| 太陽最怕在失輝不利事業，縱得富貴榮耀，也十分辛勞。日月最嫌反背，乃為失輝。（太陽在申酉戌亥子，或夜生人，乃為失輝。太陰在卯辰巳午未，或晝生人，乃為失輝）|;
		      }
# ＊ 日月命身居丑未，三方無吉反為凶。（子午辰戌命身則佳）

		    if($self->born(  time=>["丑","未"] ) && ! $self->has_sixlucky ()  ){
			      push @{$res->{$k}->{"additional"} },qq|三方無吉反為凶。（子午辰戌命身則佳）
				|;
			}	

# ＊ 日月左右合為佳。
		  if( $self->has_jiahui(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
 # ＊ 日月在疾厄宮或命宮，逢空亡，必主腰駝目瞽。
# ＊ 太陽在夫妻宮，男為諸吉聚，可因妻得貴；陷地加煞，傷妻不吉。
# ＊ 太陽在子女宮，入廟加吉，得八座，主生貴子，權柄不小。
# ＊ 太陽在財帛宮，廟旺，會吉相助，不怕巨門，無空劫，一生主富。
# ＊ 太陽在遷移宮，難招祖業，移根換葉，出祖為家。
# ＊ 太陽在田宅宮，廟旺，得祖、父蔭澤。
# ＊ 日月照壁。（日月臨田宅宮是也，喜居墓庫）
# ＊ 太陽是事業宮主，居事業宮為得位，太陽廟旺為主管階層，太陽在失輝多從事勞動性事業。 
# ＊ 日月在疾厄宮或命宮，逢空亡，必主腰駝目瞽。
# ＊ 太陽入限，廟旺，左右諸吉星皆至，大小二限俱到，必有驟興之喜。
# ＊ 太陽入限，陷地，羊陀鈴星集限，主目下有憂，或生克父母。
# ＊ 日月守命，不如照合併明。（日月守命，吉多主吉，凶多主凶。若吉少亦不為美論）
# ＊ 太陽守命於戌亥子，逢巨門，一生勞碌貧忙，更主眼目有傷，與人寡和招非。
# ＊ 日月陷宮逢惡煞，勞碌奔波。

#####查失辉



		############--------------######

		   $res->{$k}->{"main"}.=  qq|
		      日生最宜，急公好義，為官祿主。
		      擁有無私的意念，待人誠懇熱情，博愛、光明、好濟施、好面子、積極、主動。刑克陽性近親。女命對配偶時有埋怨及挑剔。易接近清高工作，如研究學術、考試、文藝、公職等。易患眼疾、腦神經衰弱、心臟、血壓、糖尿等疾病。
		      身態：人面色紅潤，相貌方圓，體格雄壯，雄氣有威，形貌堂堂。
		      個性：說話過於直接，毫不保留，所以有時難免讓人受不了，而得罪他人。並且歡爭論，容易生氣。做事積極主動，外交場合表現大方，喜歡參加活動，結交朋友。個性坦率不計得失，脾氣稍急燥。		      		

|;

# # 太陽的旺度是廟、旺，性情豪放，心慈好施，稟性聰明，志高氣傲。
# # 言行舉止之間有帶男性氣質，個性強、異性緣佳，所以不會寂寞。
		  if($you->{ziwei}->{"太陽"}->{bright} eq "廟" || $you->{ziwei}->{"太陽"}->{bright} eq "旺" ){
		       push @{$res->{$k}->{"additional"} },qq|性情豪放，心慈好施，稟性聰明，志高氣傲。言行舉止之間有帶男性氣質，個性強、異性緣佳，所以不會寂寞。|;
		   }
# # 太陽的旺度為陷，作事多進多退，性情急躁。
		  if($you->{ziwei}->{"太陽"}->{bright} eq "陷"){
		       push @{$res->{$k}->{"additional"} },qq|中矮身型。作事多進多退，性情急躁。|;
		   }
# # 命宮的宮位為「申」，作事有頭無尾，事先則勤於工作，做事非常認真，而終則疏懶隨便，求學不求甚解。
		  if($self->born(  time=>["申"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|作事有頭無尾，事先則勤於工作，做事非常認真，而終則疏懶隨便，求學不求甚解。|;
		  }
# # 命宮的宮位為「酉」，貴而不顯，富而不久；外求美觀，內實空虛。
		  if($self->born(  time=>["申"])    ){
		       push @{$res->{$k}->{"additional"} },qq|貴而不顯，富而不久；外求美觀，內實空虛。|;
		  }
# # 同一命宮中有其他星宿時：
# # 命宮有：火星，性情天真，感情用事，辛勞不得人緣。
# # 命宮的宮位是「戌、亥、子、丑」，主人作事勞碌，虛浮而不實際。
		  if($self->born(  time=>["戌","亥","子","丑"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|主人作事勞碌，虛浮而不實際|;
		  }

# # 女命太陽的旺度為廟，性格貞烈豪爽，有丈夫氣。
		  if( $you->{sex} eq 1 && $you->{ziwei}->{"太陽"}->{bright} eq "廟" ){
		       push @{$res->{$k}->{"additional"} },qq|性格貞烈豪爽，有丈夫氣。|;

		  }


	      }

		################   武曲   ####################  
		if($k eq "武曲"){
		   $res->{$k}->{"main"}.=  qq|
 容貌：形小聲高、顴突頤張。

性格：剛強果決、心直無毒。決斷雖直、稍嫌短慮。

人格類型：領導型 (決策力)。

個性特質：事業、冷靜、剛毅、果決、主觀 、勇武剛烈、田產財富、廟堂、轉換轉變。能夠針對手中的證據加以深思熟慮，同時對複雜事物能加以判斷，而達成結論。

愛情：敢愛敢恨。

優點：剛毅果決，自立自強，吃苦耐勞，勇於任事，不畏挫折，負責盡職。
缺點：孤僻自憐，倔強固執，待人欠缺圓通，處事略嫌嚴苛，自我要求過高，權力慾望太大。

  財星。有魄力，做事乾淨俐落，個性爽快，能克勤克儉，能吃苦，遇事果決能當機立斷，在事業上(或工作上)多有表現。行為上易有勇無謀、固執、不認輸、喜怒形於色。財星不發少年人，適合在武職發展。勇敢果決處事積極，有責任心，有領導及獨當的能力，擅長理財及投資！唯個性略顯孤僻，且固執剛強不易妥協，直來直往，有稜有角，欠缺周詳考慮，心性多急躁容易得罪別人！對精神而言，可以類化為孤寡星，有孤剋的靈動力，宜男不宜女，對女性而言是“寡宿星”，不利六親，男女皆不宜早婚。男命因有事業，可發揮比較沒關係，女命逢之婚姻必然多困，有獨守空閨之象。喜化祿、左右星來聚，最怕火鈴。對錢敏感的他，投資的方法有千百種，是生活節儉型的。重義氣、不肯輕易認輸的武曲星，是最易被野性不愛約束的另一半所吸引。

		      性剛毅果決，較不受管束。
		      大多剛強果斷，心直無毒，形小聲高而量大，喜好體育運動。重義氣，有堅韌不拔的精神，講信用，心直口快，言語直爽。對四化格外敏感。努力工作就能擁有財庫，其職業與經濟、金屬有關。利軍、警、武職。
		      身態：人面色青白，面型圓長，額寬眉粗，毛髮粗硬，性情至剛至毅，性情剛強，處事果決。
		      個性：做人誠實信用，重義氣，心性直爽，對於不滿意的事物，皆直接反應。有執行力、毅力、開創、勇敢、心性開朗、講義氣。
		      
		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# # #  ＊ 武曲守命，西北生人福厚，東南生人平常。
# # # ＊ 武曲廟垣，威名赫奕。（為將星得地格。辰戌丑未生人，安命辰戌丑未宮，主富貴。如不在辰戌丑未者次之）
		  if($self->born(  time=>["辰","戌","丑","未"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|主富貴|;
		  }

# # # ＊ 武曲閑宮，多手藝。（武曲在巳亥宮守命。加煞者，手藝安身）
		  if($self->born(  time=>["亥"] ) && $self->has_sixghost() ){
		       push @{$res->{$k}->{"additional"} },qq|手藝安身|;
		  }
# # # ＊ 武曲天府同宮於子午，主有壽。
		  if($self->has_stars(  stars=>["天府"])  && $self->born(  time=>["子","午"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|主有壽|;
		  }

# # # ＊ 武曲貪狼同宮於丑未，主少年不利，先貧後富，慳吝之人。

		  if($self->has_stars(  stars=>["貪狼"])  && $self->born(  time=>["丑","未"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|主少年不利，先貧後富，慳吝之人。|;
		  }

		  
# # # ＊ 武曲破軍同宮於巳亥，難貴顯。
		  if(  $self->has_stars(  stars=>["破軍"])  && $self->born(  time=>["巳","亥"] )  ){
	
			       push @{$res->{$k}->{"additional"} },qq|難貴顯。|;
		      	      
		      
		  }
# # # ＊ 武曲破軍，破祖破家勞碌。
		  if(  $self->has_stars(  stars=>["破軍"])  ){
	
			       push @{$res->{$k}->{"additional"} },qq|破祖破家勞碌。|;
		      	      
		    } 
		      
# # # ＊ 武曲會破軍廉貞于卯宮，必見木壓雷驚。
		  if(  $self->born(  time=>["卯","宮"] ) &&  $self->has_jiahui(  stars=>["破軍","廉貞"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|必見木壓雷驚。|;
		      	      
		      
		  }
# # # ＊ 武曲與破軍貪狼會於子宮，必主投河溺水。
		  if(  $self->born(  time=>["子"] ) &&  $self->has_jiahui(  stars=>["破軍","貪狼"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|必見木壓雷驚。|;
		      	      
		      
		  }
		  
# # # ＊ 武曲與廉貞會于卯宮，必主破敗。
		  if(  $self->born(  time=>["卯"] ) &&  $self->has_jiahui(  stars=>["廉貞"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|必主破敗。|;
		      	      
		      
		  }
		  
# # # ＊ 武曲與廉貞貪狼及七殺會合，便作經商。
		  if(  $self->has_jiahui(  stars=>["廉貞","貪狼","七殺"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|便作經商。|;
		      	      
		      
		  }
		  
# # # ＊ 武曲入廟，與昌曲同宮，出將入相。
		  if($you->{ziwei}->{"武曲"}->{bright} eq "廟" && $self->has_stars(  stars=>["文昌","文曲"]) ){
		       push @{$res->{$k}->{"additional"} },qq|出將入相。|;
		   }
# # # ＊ 武曲魁鉞居廟旺，財賦之官。
		  if(($you->{ziwei}->{"武曲"}->{bright} eq "廟" || $you->{ziwei}->{"武曲"}->{bright} eq "旺" ) && $self->has_stars(  stars=>["天魁","天鉞"]) ){
		       push @{$res->{$k}->{"additional"} },qq|財賦之官。|;
		   }
		   
# # # ＊ 武曲祿馬同宮，發財遠鄉。
		  if( $self->has_stars(  stars=>["祿存","天馬"]) ){
		       push @{$res->{$k}->{"additional"} },qq|出將入相。|;
		   }
# # # ＊ 武曲羊陀兼火宿，喪命因財。
		  if( $self->has_stars(  stars=>["擎羊","陀羅"]) && $self->has_stars(  stars=>["火星","寡宿"]) ){
		       push @{$res->{$k}->{"additional"} },qq|喪命因財。|;
		   }
# # # ＊ 武曲火鈴同宮，因財被劫。、
		  if( $self->has_stars(  stars=>["火星","鈴星"]) ){
		       push @{$res->{$k}->{"additional"} },qq|因財被劫。|;
		   }
# # # ＊ 武曲遇羊陀，主孤克。
		  if( $self->has_stars(  stars=>["擎羊","陀羅"]) ){
		       push @{$res->{$k}->{"additional"} },qq|主孤克。|;
		   }
# # # ＊ 武曲守命，四煞衝破，孤貧不一，破相延壽。
		  if(  $self->has_fourghost()   ){
	
			       push @{$res->{$k}->{"additional"} },qq|四煞衝破,孤貧不一，破相延壽。|;
		      	      
		      
		  }
# # # ＊ 武曲之星為寡宿。（夫星柔弱，婦奪夫權，方免刑克。若兩剛相敵，必主刑克生離）
	
			       push @{$res->{$k}->{"additional"} },qq|（夫星柔弱，婦奪夫權，方免刑克。若兩剛相敵，必主刑克生離）|;

# # # ＊ 武曲代表財富。
			       push @{$res->{$k}->{"additional"} },qq|代表財富。|;

# # # ＊ 女命武曲：勞碌，事業保守，個性固執。
		  if( $you->{sex} eq 1 ){
		       push @{$res->{$k}->{"additional"} },qq|勞碌，事業保守，個性固執。|;

		  }


# # # ＊ 武曲男性有毅力，學東西能專精。
		  if( $you->{sex} eq 0 ){
		       push @{$res->{$k}->{"additional"} },qq|男性有毅力，學東西能專精。|;

		  }


# # # ＊ 武曲加會祿、祿存，天馬有賺錢能力，社交能力強。
		  if($self->has_jiahui_huaji( star=>$k, stars=>["祿"] ) ||   $self->has_jiahui(  stars=>["祿存","天馬"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|社交能力強。|;
		      	      
		      
		  }
		  
# 		   print Dumper($self)."----------";


# # # ＊ 武曲無左輔、右弼，無有利助手，財來財去，辛勞。
		  if(! $self->has_stars(  stars=>["左輔","右弼"]) ){
		       push @{$res->{$k}->{"additional"} },qq|無有利助手，財來財去，辛勞。|;
		   }


# # # ＊ 武曲加會文昌、文曲，易有才藝，為儒將不宜武將。
		  if(  $self->has_jiahui(  stars=>["文昌","文曲"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|易有才藝，為儒將不宜武將。|;
		      	      
		      
		  }


# # # ＊ 武曲加會天魁、天鉞，貴人相助，多賺錢機運。
		  if(  $self->has_jiahui(  stars=>["天魁","天鉞"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|貴人相助，多賺錢機運。|;
		      	      
		      
		  }
# # # ＊ 武曲化祿：為人剛正，善於賺錢。
		  if($self->has_huaji( star=>$k, stars=>[ "祿"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|為人剛正，善於賺錢。   |;
		  }	
		  
# # # ＊ 武曲化權：有實力，有本事賺錢，財源不斷。
		  if($self->has_huaji( star=>$k, stars=>[ "權"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|有實力，有本事賺錢，財源不斷。   |;
		  }	
		  
# # # ＊ 武曲化科：易獲財利、名聲，為人心較軟，不宜武職。
		  if($self->has_huaji( star=>$k, stars=>[ "科"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|易獲財利、名聲，為人心較軟，不宜武職。   |;
		  }	
# # # ＊ 武曲化忌：心情放不開，固執，易有財務是非，破財，為財多憂。
		  if($self->has_huaji( star=>$k, stars=>[ "忌"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|心情放不開，固執，易有財務是非，破財，為財多憂。   |;
		  }	
# # # ＊ 武曲加會科、權、祿：財源不斷。
		  if($self->has_jiahui_huaji( star=>$k, stars=>["祿","科","權"] ) ){
	
			       push @{$res->{$k}->{"additional"} },qq|財源不斷。|;
		      	      
		      
		  }
# # # ＊ 武曲加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌為人不易聚富，身體易受傷，宜習一技之長。
		  if( $self->has_huaji( star=>$k, stars=>[ "忌"] )  &&  $self->has_jiahui(  stars=>["火星","鈴星","擎羊","陀羅","地空","地劫"]) ){
	
			       push @{$res->{$k}->{"additional"} },qq|為人不易聚富，身體易受傷，宜習一技之長。|;
		      	      
		      
		  }
		  
# # # ＊ 大小限遇武曲星有財祿之時機。
		  
# # # ＊ 武曲為北斗將星、是財帛宮主，居財帛宮為得位，其力較大，在命宮田宅宮位都主財。
# # # ＊ 武曲加吉坐遷移，鉅賈高賈。（吉多方論）
# # # ＊ 武曲貪狼財宅位，橫發資財。
# # # ＊ 武曲守於財帛，多為財賦之官。 
# # # ＊ 財居財位，遇者富奢。（武曲、紫微、天府居於財帛宮，又兼化祿及祿存，必主富奢。二限者逢之，主大發跡）
# # # ＊ 武曲破軍同于財宮，財到手而成空。
# # # ＊ 武曲破軍同宮於巳亥，臨大小二限之中，主是非之撓。
		  
# 		  
# 命宮的宮位是「辰、戌」，身材瘦長。
		  if($self->born(  time=>["辰","戌"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|身材瘦長。|;
		  }

# 命宮的宮位為「酉」且命宮有七殺，身長高大。
		  if($self->born(  time=>["酉"] ) && $self->has_stars(  stars=>["七殺"])){
		       push @{$res->{$k}->{"additional"} },qq|身長高大。|;
		  }
# 命宮的宮位為「卯」，身材肥胖。身材形小而聲高大，其量亦大。
		  if($self->born(  time=>["卯"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|身材肥胖。身材形小而聲高大，其量亦大。|;
		  }

# 命宮有：破軍，為獨夫的性格，一生必多是非。
		  if( $self->has_stars(  stars=>["破軍"])){
		       push @{$res->{$k}->{"additional"} },qq|為獨夫的性格，一生必多是非。|;
		  }

# 命宮有：擎羊，七殺，天空，地劫，容易因財利而持刀動武。
		  if($self->has_stars(  stars=>["擎羊","七殺","天空","地劫"]) ){
		       push @{$res->{$k}->{"additional"} },qq|容易因財利而持刀動武。|;
		  }
# 男子漢大丈夫的氣慨，能掌握大權，更可富貴。不是很開朗、且保守、認命、勞碌、孤獨感。
		       push @{$res->{$k}->{"additional"} },qq|男子漢大丈夫的氣慨，能掌握大權，更可富貴。不是很開朗、且保守、認命、勞碌、孤獨感。|;
# 命宮有：天府、左輔、右弼、天魁、天鉞、祿存、天馬，是女中豪傑，處事果斷，志氣高昂，富貴雙全。
		  if($you->{sex} eq 1 && $self->has_stars(  stars=>["天府","左輔","右弼","天魁","天鉞","祿存","天馬"])){
		       push @{$res->{$k}->{"additional"} },qq|女中豪傑，處事果斷，志氣高昂，富貴雙全。|;
		  }


# 命宮有：六煞，應該以武職文做。宜從事軍警刑法之職。
		  if( $self->has_sixghost()){
		      push @{$res->{$k}->{"additional"} },qq|應該以武職文做。宜從事軍警刑法之職。;|;

		  }
# 命宮有：祿存、天馬、化祿、化科，福厚。

		  if( $self->has_stars(  stars=>["祿存","天馬"]) || $self->has_huaji( star=>$k, stars=>[ "祿","科"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|福厚。|;
		  }


# 命宮有：文昌、文曲、六吉星，出將入相，能掌百萬雄兵，以武職最為相宜；人則多學多能。
		  if( $self->has_stars(  stars=>["文昌","文曲"]) || $self->has_sixlucky() ){
		      push @{$res->{$k}->{"additional"} },qq|出將入相，能掌百萬雄兵，以武職最為相宜；人則多學多能。;|;

		  }

# 命宮有：七殺、或命宮有火星，財利事業而招遇到意外災禍。
		  if($self->has_stars(  stars=>["七殺","火星"])){
		      push @{$res->{$k}->{"additional"} },qq|財利事業而招遇到意外災禍。|;
		  }

# 命宮有：化忌，大耗，有盜賊搶劫等事發生。
		    if($self->has_stars(  stars=>["大耗"]) || $self->has_huaji( star=>$k, stars=>[ "忌"] )){
			 push @{$res->{$k}->{"additional"} },qq|有盜賊搶劫等事發生。|;
		    }


# 命宮有：祿存、且命宮無天空及地劫，雖能富有，但多為是損人利己的自私者。

		  if( $self->has_stars(  stars=>["祿存"])  &&  ! $self->has_stars(  stars=>["天空","地劫"])){
		       push @{$res->{$k}->{"additional"} },qq|雖能富有，但多為是損人利己的自私者。 |;
		  }

# 命宮有：左輔、右弼，人為外剛強而內忠厚。
		  if($self->has_stars(  stars=>["左輔","右弼"]) ){
		       push @{$res->{$k}->{"additional"} },qq|人為外剛強而內忠厚。|;
		  }

# 命宮的宮位為「子」，且命宮有：天馬，可以遠涉重洋遨遊國外。

		  if($self->born(  time=>["子"] )   && $self->has_stars(  stars=>["天馬"]) ){
		       push @{$res->{$k}->{"additional"} },qq|可以遠涉重洋遨遊國外。|;
		  }

		}

		################   天同   ####################  
		if($k eq "天同"){
		   $res->{$k}->{"main"}.= qq|福德宮之主，心性仁慈耿直。
 容貌：眉輕眼秀、唇豐齒齊。

性格：為人謙虛、臨事和平。雖為溫順、流於軟弱。

人格類型：合作型 (敏感力)。

個性特質：福氣、樂天、天真、單純、懶散、抗壓性弱 、喜勞心、靈感的、軟弱、等待。瞭解他人所需及感想。

愛情：寬容平和 。

優點：平易近人，知足常樂，心地寬宏，不記仇怨，樂於施捨，貴人運強，注重生活情趣，不會爭權奪利。
缺點：畏首畏尾，感情用事，大而化之，耐性不足，缺乏幹勁，想多做少。

 天同是一顆福星，具有益壽、消災解厄之靈動力，福報極深。主安享，有口服，性情溫和謙遜有禮，富有人情味。善於協調人際關係，有機智，溫文儒雅，好文學，心慈耿直喜助人，凡事不與人計較，不偏激，讓人感受溫柔隨和而帶來好人緣。為人較注重精神生活感受，喜歡過悠閒生活，品味高。雖聰明好學卻不專心，總是先勤後惰。因為是福星，故喜歡安享，得過且過，保守成規，心性稍為軟弱，有點懶散，所以也比較沒有開創力及雄心壯志，處事也不很積極，理想高、幻想多而不務實，須要受到挫折或刺激才會奮發。男命逢之宜有化權、化科，否則缺乏進取之志。女命逢之，主有福氣，可是最怕與水多的星辰聚會，難免感情有困。天同星可類化為福利事業、福德正神之類。天同對羊陀、火鈴的煞氣較不怕。天同逢煞星反而激勵它的奮發圖強，觸動其鬥志，雖然會使生活變得勞碌艱辛，但總是會有成功的機會！天同星的人一直都是享樂主義的信徒，而消費與玩樂便是他解壓最好也最簡單的方法了。在感情的路上則易出現老少配的局面。

福德宮之主，心性仁慈耿直。

		    偏向享受，帶點文藝氣息，喜歡吃喝玩樂，容易受到環境影響。喜悠閒、平淡生活，重精神、物質享受，會昌曲有文學天賦。會使合夥之股東難以習慣。
		    身態：其人肥滿，體型胖圓，面色黃白，面貌似孩童，眉清目秀，有幽默感，因福相，所以人緣好。
		    個性：為人性情溫良，謙虛而不驕傲，稟性耿直，志趣高超，思想聰敏，能學能成。
		    多學少精，什麼都略懂一點，已知足，致使不再深究，換言之，乃為樂觀之人，卻不積極。但由於過份的情緒化，因而影響事業，必須經過艱危後，然後才能有奮發之心。
		      吉凶：
		      但由於過份的情緒化，因而影響事業，必須經過艱危後，然後才能有奮發之心。




		      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }


# ＊ 天同守命，不怕劫煞相侵，不怕諸煞同宮。
			   push @{$res->{$k}->{"additional"} },qq|不怕劫煞相侵，不怕諸煞同宮。|;
# ＊ 天同會吉壽元長。
		  if(  $self->has_sixlucky() ){
		      push @{$res->{$k}->{"additional"} },qq|壽元長。|;

		  }

# ＊ 天同戌宮為反背，丁人化吉主大貴。
		  if($self->born(  time=>["戌"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|反背，丁人化吉主大貴。|;
		  }

# ＊ 天同居巳亥守命，會四煞，殘疾孤克。
		  if($self->born(  time=>["巳","亥"] ) &&  $self->has_jiahui(  stars=>["擎羊","陀羅","火星","鈴星"])  ){
		       push @{$res->{$k}->{"additional"} },qq|殘疾孤克。|;
		  }

# ＊ 天同太陰同在午宮守命，加煞重，肢體羸黃。
		  if($self->has_stars(  stars=>["太陰"]) && $self->born(  time=>["午"] ) &&  $self->has_fourghost()  ){
		       push @{$res->{$k}->{"additional"} },qq|肢體羸黃。|;
		  }

# ＊ 天同守命，遇巨門火鈴，必生異痣。
		  if($self->has_stars(  stars=>["火星","鈴星"])  ){
		       push @{$res->{$k}->{"additional"} },qq|必生異痣。|;
		  }
# ＊ 天同天梁同在寅申守命，甲乙丁己生人福厚。
		  if($self->born(  time=>["甲","乙","丁","己"] ) &&$self->has_stars(  stars=>["天梁"])  ){
		       push @{$res->{$k}->{"additional"} },qq|福厚。|;
		  }
# ＊ 天同守命，遇左右昌梁，貴顯。
		  if($self->has_stars(  stars=>["左輔","右弼","文昌","天梁"])  ){
		       push @{$res->{$k}->{"additional"} },qq|貴顯。|;
		  }
# ＊ 天同擎羊居午位，丙戊生人鎮禦邊疆。（為馬頭帶箭格。富且貴）
		  if($self->born(  time=>["午"] ) &&$self->born(  time=>["丙","戊"] ) &&$self->has_stars(  stars=>["擎羊"])  ){
		       push @{$res->{$k}->{"additional"} },qq|鎮禦邊疆。（為馬頭帶箭格。富且貴）|;
		  }
# ＊ 天同擎羊同宮，身體遭傷。
		  if($self->has_stars(  stars=>["擎羊"])  ){
		       push @{$res->{$k}->{"additional"} },qq|身體遭傷。|;
		  }
# ＊ 天同陀羅同宮，肥滿而目渺。
		  if($self->has_stars(  stars=>["陀羅"])  ){
		       push @{$res->{$k}->{"additional"} },qq|肥滿而目渺。|;
		  }
# ＊ 女命天同必是賢。（子生人命坐寅，辛生人命坐卯，丁生人命坐戌，入格。丙辛生人命中吉。巳亥逢此化吉，雖美必淫）
		  if( $you->{sex} eq 1 ){
		       push @{$res->{$k}->{"additional"} },qq|必是賢|;
		      if(  ( $self->born(  time=>["子"] )  &&$self->born(  time=>["寅"] ) ) || ( $self->born(  time=>["丁"] )  &&$self->born(  time=>["戌"] ) )   ){
			  push @{$res->{$k}->{"additional"} },qq|入格。|;
		      }
		      if(   $self->born(  time=>["丙","辛"] )   ){
			  push @{$res->{$k}->{"additional"} },qq|命中吉。|;
		      }		 
		      if(   $self->born(  time=>["巳","亥"] )   ){
			  push @{$res->{$k}->{"additional"} },qq|逢此化吉，雖美必淫。|;
		      }	

# ＊ 女命天同，聰明伶俐。逢煞衝破，刑夫克子。
			  push @{$res->{$k}->{"additional"} },qq|聰明伶俐。|;

		      if(   $self->has_sixghost( )   ){
			  push @{$res->{$k}->{"additional"} },qq|逢煞衝破，刑夫克子。|;
		      }	
# ＊ 女命，天同太陰同宮，雖美而淫，偏房侍妾。
		      if($self->has_stars(  stars=>["太陰"])  ){
			  push @{$res->{$k}->{"additional"} },qq|雖美而淫，偏房侍妾。|;
		      }
# ＊ 女命，天同天梁同宮，宜作偏房。
		      if($self->has_stars(  stars=>["天梁"])  ){
			  push @{$res->{$k}->{"additional"} },qq|宜作偏房。|;
		      }
		}

# ＊ 天同代表溫和，享受。
			  push @{$res->{$k}->{"additional"} },qq|代表溫和，享受。|;


# ＊ 天同加會祿、祿存、天馬；喜愛自由享受，為人懶散。

		      if($self->has_jiahui(  stars=>["祿存","天馬"]) ||  $self->has_jiahui_huaji( star=>$k, stars=>["祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|喜愛自由享受，為人懶散。|;
		      }

# ＊ 天同加會左輔、右弼，人緣佳，生活自在。

		      if($self->has_jiahui(  stars=>["左輔","右弼"]) ){
			  push @{$res->{$k}->{"additional"} },qq|人緣佳，生活自在。|;
		      }

# ＊ 天同加會文昌、文曲，有學問才藝，易為情所困。
		      if($self->has_jiahui(  stars=>["文昌","文曲"]) ){
			  push @{$res->{$k}->{"additional"} },qq|有學問才藝，易為情所困。|;
		      }
# ＊ 天同加會天魁、天鉞，有貴人相助，桃花重。
		      if($self->has_jiahui(  stars=>["天魁","天鉞"]) ){
			  push @{$res->{$k}->{"additional"} },qq|有貴人相助，桃花重。|;
		      }
# ＊ 天同化祿：福氣好但懶散，善於享受。
		  if($self->has_huaji( star=>$k, stars=>[ "祿"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|福氣好但懶散，善於享受。|;
		  }

# ＊ 天同化權：有鬥志、志向。
		  if($self->has_huaji( star=>$k, stars=>[ "權"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|有鬥志、志向。|;
		  }
# ＊ 天同化忌：有福享不到，不愛工作，多操心。
		  if($self->has_huaji( star=>$k, stars=>[ "忌"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|有福享不到，不愛工作，多操心。|;
		  }
# ＊ 天同加會科、權、祿；可化凶厄，作事積極。

		      if( $self->has_jiahui_huaji( star=>$k, stars=>["權","科","祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|可化凶厄，作事積極。|;
		      }

# ＊ 天同加會火星，鈴星；加強天同的積極性。
		      if($self->has_jiahui(  stars=>["火星","鈴星"]) ){
			  push @{$res->{$k}->{"additional"} },qq|加強天同的積極性。|;
		      }
# ＊ 天同加會擎羊、陀羅多主受傷，開刀，辛勞。
		      if($self->has_jiahui(  stars=>["擎羊","陀羅"]) ){
			  push @{$res->{$k}->{"additional"} },qq|多主受傷，開刀，辛勞。|;
		      }
# ＊ 天同加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌主作事忙亂。
		      if($self->has_jiahui(  stars=>["擎羊","陀羅","火星","鈴星","地劫","地空"]) ||  $self->has_huaji( star=>$k, stars=>[ "忌"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|主作事忙亂。|;
		      }
# ＊ 大小限遇天同星凡事如意。
# ＊ 天同為南斗星、是福德宮主，居福德宮主為得位。




# 命宮有：天梁、左輔、右弼、天魁、天鉞、文昌、文曲，福厚壽長具文學天賦。

		  if($self->has_stars(  stars=>["天梁","左輔","右弼","天魁","天鉞","文昌","文曲"])){
		       push @{$res->{$k}->{"additional"} },qq|福厚壽長具文學天賦。|;
		  }
# 命宮有：祿存，財福雙美。

		  if($self->has_stars(  stars=>["祿存"])  ){
		       push @{$res->{$k}->{"additional"} },qq|財福雙美。|;
		  }
# 命宮的宮位為「亥」，且天同為化忌，主刑剋孤單，為他人做牛做馬；或有破相病災。
		  if($self->born(  time=>["亥"] )   && $self->has_huaji( star=>$k, stars=>[ "忌"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|主刑剋孤單，為他人做牛做馬；或有破相病災。|;
		  }

# 女命為人聰明機巧。
		  if( $you->{sex} eq 1){
		       push @{$res->{$k}->{"additional"} },qq|女命為人聰明機巧。|;
# 天同的旺度為廟，且命宮有：祿存、化祿，幫夫教子，福祿雙全。
			if($you->{ziwei}->{"天同"}->{bright} eq "廟" && $self->has_huaji( star=>$k, stars=>[ "祿"] ) && $self->has_stars(  stars=>["祿存"]) ){
			     push @{$res->{$k}->{"additional"} },qq|幫夫教子，福祿雙全。|;
			}

# 命宮有：太陰，喜歡修飾美容，財祿雖足，但福不全。
			if($self->has_stars(  stars=>["太陰"])   ){
			     push @{$res->{$k}->{"additional"} },qq|喜歡修飾美容，財祿雖足，但福不全。|;
			}


		  }

	      }

		################   廉貞   ####################  

		if($k eq "廉貞"){
		   $res->{$k}->{"main"}.= qq|不拘禮儀，易怒好勝。
 容貌：眉寬眼大、口潤耳垂。

性格：性硬浮蕩、愛好紛爭。雖為聰明、流於邪惡。

人格類型：開創型 (忍耐力)。

個性特質：公關、毅力、不屈、堅持、不服輸 、邪惡、桃花、奸詐狡猾、助長惡勢力、貞烈、固執。能在壓力下穩定地完成目標。

愛情：自知自信。

優點：負責盡職，見識不凡，思想新穎，是非分明，敢做敢當，積極進取。
缺點：心高氣傲，情緒多變，自視過高，一意孤行，鋒芒太露，逞強好勝，要求過嚴，心狂性暴。

		      廉貞星是一顆多變化的星曜，性格也有正邪二面的表現，讓人難以捉摸，吉凶變化相當大。事業心重，能言善道，有機謀奇智，公關人才，社交手腕相當敏銳，反應特別快，多才多藝，會要求自己盡善盡美，而且要求嚴苛，但容易犯小人，人情淡薄，忽略婚姻生活，在乎工作績效。為次桃花星，桃花極重，異性緣很好。廉貞坐命的人很適合從政，容易成為公務人員，公職或經商在工作上的表現相當積極有上進心，做事相當盡責，不會先計較結果，總是會先付出，才會求回報，不會敷衍騙人，給人親和灑脫不計較的印象，也因太過開放隨緣，一生是非較多。唯重感情欠理性，為人性急好勝心強，不太合群易得罪他人，內心世界不太願讓人瞭解，也造成個性的捉摸不定！最喜歡天魁、天鉞。祿存、天相可解其凶，但是單守時可是主清白的唷。此外，廉貞可是很會找路子來買東西，也最鐵齒。

		    利於公職人員，又如公共關係、行政管理、社會工作有關之職業。有潛伏性暴躁個性，可因教育而改變。人際關係良好。
		    身態：身長體健，眉寬口闊而觀高，面型圓瘦或長型，臉色黃或略帶黃黑色。
		    個性：不拘小節，好勝好辯，記憶力很強，脾氣暴燥，雖然講理但不合群。		      		


		  |;




		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 廉貞在命身宮為次桃花，若居旺宮，則賭博迷花而致訟。
			   push @{$res->{$k}->{"additional"} },qq|為次桃花|;
			if($you->{ziwei}->{"廉貞"}->{bright} eq "旺"  ){
			     push @{$res->{$k}->{"additional"} },qq|賭博迷花而致訟。|;
			}

# ＊ 廉貞在未申宮守命，無四煞，富貴聲揚播遠名。（為雄宿朝垣格。加煞平常）

		  if($self->born(  time=>["未","申"] )   && !$self->has_fourghost()  ){
		       push @{$res->{$k}->{"additional"} },qq|富貴聲揚播遠名。（為雄宿朝垣格。加煞平常）|;
		  }
# ＊ 廉貞巳亥宮守命，主下賤孤寒，棄祖離家。
		  if($self->born(  time=>["巳","亥"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|主下賤孤寒，棄祖離家。|;
		  }

# ＊ 廉貞卯酉宮守命，加四煞，公門胥吏。（或巧藝之人）
		  if($self->born(  time=>["卯","酉"] )   && $self->has_fourghost()  ){
		       push @{$res->{$k}->{"additional"} },qq|公門胥吏。（或巧藝之人）|;
		  }

# ＊ 廉貞七殺居廟旺，反為積富之人。（廉貞七殺同宮在未，或七殺居午，廉貞在申。身命遇之是也。若陷地化忌，貧賤殘疾）
			if($self->has_stars(  stars=>["七殺"]) && ($you->{ziwei}->{"廉貞"}->{bright} eq "廟" || $you->{ziwei}->{"廉貞"}->{bright} eq "旺" )  ){
			     push @{$res->{$k}->{"additional"} },qq|反為積富之人。|;
			}
			if($self->has_stars(  stars=>["七殺"]) && $self->born(  time=>["未"] ) ){
			     push @{$res->{$k}->{"additional"} },qq|身命遇之是也。|;
			}
			if($self->born(  time=>["申"] )  ){
			  foreach my $s ($self->find_stars(pos=>($self->{pos} + 10 )%12) ){
			    if($s eq ""){
				push @{$res->{$k}->{"additional"} },qq|身命遇之是也。
				|;
			      }

			    }
			}

		  if($you->{ziwei}->{"廉貞"}->{bright} eq "陷"  && $self->has_huaji( star=>$k, stars=>[ "忌"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|貧賤殘疾。|;
		  }
# ＊ 廉貞會七殺，居巳亥，流蕩天涯。
		  if($self->has_stars(  stars=>["七殺"]) &&  $self->born(  time=>["亥"] )      ){
		       push @{$res->{$k}->{"additional"} },qq|流蕩天涯。|;
		  }

# ＊ 廉貞破軍火鈴同宮，狼心狗肺。
		  if($self->has_stars(  stars=>["破軍","火星","鈴星"])     ){
		       push @{$res->{$k}->{"additional"} },qq|狼心狗肺。|;
		  }
# ＊ 廉貞破軍火星居陷地，自縊投河。
		  if($self->has_stars(  stars=>["破軍","火星","鈴星"])  &&  $you->{ziwei}->{"廉貞"}->{bright} eq "陷"   ){
		       push @{$res->{$k}->{"additional"} },qq|自縊投河。|;
		  }

# ＊ 廉貞破軍與日月以濟行，目疾不免。
		  if($self->has_stars(  stars=>["破軍"])  &&  $self->has_stars(  stars=>["太陽","太陰"])   ){
		       push @{$res->{$k}->{"additional"} },qq|目疾不免。|;
		  }

# ＊ 廉貞遇文曲，好禮樂。
		  if($self->has_stars(  stars=>["文曲"])   ){
		       push @{$res->{$k}->{"additional"} },qq|好禮樂。|;
		  }

# ＊ 廉貞遇七殺，顯武職。
		  if($self->has_stars(  stars=>["七殺"])   ){
		       push @{$res->{$k}->{"additional"} },qq|顯武職。|;
		  }
# ＊ 廉貞遇祿存，主富貴。
		  if($self->has_stars(  stars=>["祿存"])   ){
		       push @{$res->{$k}->{"additional"} },qq|主富貴|;
		  }
# ＊ 廉貞擎羊同宮，是非日有。
		  if($self->has_stars(  stars=>["擎羊"])   ){
		       push @{$res->{$k}->{"additional"} },qq|是非日有。|;
		  }
# ＊ 廉貞遇羊陀，膿血不免。
		  if($self->has_stars(  stars=>["擎羊","陀羅"])   ){
		       push @{$res->{$k}->{"additional"} },qq|膿血不免。|;
		  }
# ＊ 廉貞同火星于陷宮之地，主投河自縊。
		  if($self->has_stars(  stars=>["火星"]) &&  $you->{ziwei}->{"廉貞"}->{bright} eq "陷"  ){
		       push @{$res->{$k}->{"additional"} },qq|主投河自縊。|;
		  }


# ＊ 廉貞遇武曲於受制之鄉，恐木壓蛇傷。
		  if($self->has_stars(  stars=>["武曲"])  ){
		       push @{$res->{$k}->{"additional"} },qq|於受制之鄉，恐木壓蛇傷。|;
		  }

# ＊ 廉貞四煞同宮，遭刑戮或終身不能發達。

		  if($self->has_fourghost()  ){
		       push @{$res->{$k}->{"additional"} },qq|遭刑戮或終身不能發達。|;
		  }
# ＊ 廉貞白虎，刑杖難逃。（流年太歲並小限坐宮，又值白虎加臨，主官非，遭刑杖）

		  if($self->has_stars(  stars=>["白虎"]) ){
		       push @{$res->{$k}->{"additional"} },qq|刑杖難逃。（流年太歲並小限坐宮，又值白虎加臨，主官非，遭刑杖）|;
		  }

# ＊ 仲由威猛，廉貞入廟遇將軍。（申安命，二星同宮是也）
		  if( $you->{ziwei}->{"廉貞"}->{bright} eq "廟" ||  $self->born(  time=>["申"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|仲由威猛，遇將軍。|;
		  }
# ＊ 女命，廉貞清白能相守。（甲己庚癸生人，安命申酉亥子宮。丙辛乙戊生人，安命寅卯巳午宮。若辰戌丑未反賤。
		  if( $you->{sex} eq 1){

		    if(   $self->born(  time=>["甲","己","庚","癸"] )  && $self->born(  time=>["申","酉","酉","亥","子"])){
		       push @{$res->{$k}->{"additional"} },qq|清白能相守|;
		    }elsif(   $self->born(  time=>["丙","辛","乙","戊"] )  && $self->born(  time=>["寅","卯","巳","午"])){
		       push @{$res->{$k}->{"additional"} },qq|清白能相守|;
		    }else{
		       push @{$res->{$k}->{"additional"} },qq|反賤。|;

		    }
		  }
# ＊ 廉貞代表爭奪。
		       push @{$res->{$k}->{"additional"} },qq|爭奪。|;
# ＊ 廉貞聰明，不在意別人的想法。
		       push @{$res->{$k}->{"additional"} },qq|聰明，不在意別人的想法。|;
# ＊ 廉貞加會左輔、右弼，有能力，可掌大權，為人精神佳，有貴人助。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有能力，可掌大權，為人精神佳，有貴人助。|;
		  }

# ＊ 廉貞加會文昌、文曲，有明理，有魅力，感情多風波。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有明理，有魅力，感情多風波。|;
		  }
# ＊ 廉貞加會天魁、天鉞，有貴人相助，感情豐富。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有貴人相助，感情豐富。|;
		  }
# ＊ 廉貞加會科、權、祿工作順利，名利雙收。
		  if($self->has_jiahui_huaji( star=>$k, stars=>[ "科","權","祿"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|工作順利，名利雙收。|;
		  }

# ＊ 廉貞加會火星或鈴星為人衝動。
		  if( $self->has_jiahui(  stars=>["火星"]) ||  $self->has_jiahui(  stars=>["鈴星"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|為人衝動。|;
		  }
# ＊ 廉貞加會擎羊、陀羅身體多傷災，或與人爭鬥受傷。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|身體多傷災，或與人爭鬥受傷。|;
		  }
# ＊ 廉貞化祿：有想法，能力強，使人服從，支持，異性緣佳。 
		  if($self->has_huaji( star=>$k, stars=>[ "祿"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|有想法，能力強，使人服從，支持，異性緣佳。 |;
		  }

# ＊ 廉貞化忌：想不開，官司，身心難安，敗桃花，感情不定，不信邪，賭博易輸，為人叛逆，有永放不下的責任。
		  if($self->has_huaji( star=>$k, stars=>[ "忌"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|想不開，官司，身心難安，敗桃花，感情不定，不信邪，賭博易輸，為人叛逆，有永放不下的責任。|;
		  }
# ＊ 廉貞加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌莫名之災難不斷，不宜賭博易犯小人。
		  if( $self->has_jiahui(  stars=>["火星","鈴星","擎羊","陀羅","地空","地劫"])  || $self->has_jiahui_huaji( star=>$k, stars=>[ "忌"] )  ) {
			   push @{$res->{$k}->{"additional"} },qq|莫名之災難不斷，不宜賭博易犯小人。|;
		  }

# ＊ 大小限遇廉貞星有突發之幸運及桃花運。

# ＊ 廉貞貪煞破軍逢，文曲遷移作吏戎。
# ＊ 廉貞七殺會擎羊於官祿，枷杻難逃。
# ＊ 廉貞破軍會擎羊與遷移，死於外道。
# ＊ 廉貞為北斗星、是事業宮主，在身宮命宮為次桃花，居事業宮為得位，可掌權。
# ＊ 廉貞逢武曲破軍，祖業必破。


# 廉貞的旺度為陷，紙醉金迷，時常流連酒色賭博之處，而且可能因酒色賭博，而有發生訟司口舌之爭。
		   if($you->{ziwei}->{"廉貞"}->{bright} eq "陷"){
		       push @{$res->{$k}->{"additional"} },qq|紙醉金迷，時常流連酒色賭博之處，而且可能因酒色賭博，而有發生訟司口舌之爭。|;
		    }

# 命宮有：天府，身材肥胖，皮膚粗黑、內心寬厚。
		  if($self->has_stars(  stars=>["天府"])   ){
		       push @{$res->{$k}->{"additional"} },qq|身材肥胖，皮膚粗黑、內心寬厚。|;
		  }
# 命宮有：貪狼，中型身材，皮膚黃白，外表圓滑。
		  if($self->has_stars(  stars=>["貪狼"])  ){
		       push @{$res->{$k}->{"additional"} },qq|中型身材，皮膚黃白，外表圓滑。|;
		  }
# 命宮有：廉貞的旺度為廟，最適合武職。
		   if($you->{ziwei}->{"廉貞"}->{bright} eq "廟"){
		       push @{$res->{$k}->{"additional"} },qq|最適合武職。|;
		    }
# 命宮有：紫微星，威權顯赫。

		  if($self->has_stars(  stars=>["紫微"]) ){
		       push @{$res->{$k}->{"additional"} },qq|威權顯赫。|;
		  }
# 命宮有：祿存、化祿、天馬，富貴雙全。

		  if($self->has_stars(  stars=>["祿存","天馬"])  &&  $self->has_huaji( star=>$k, stars=>[ "祿"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|富貴雙全。|;
		  }
# 命宮有：文昌、文曲，好禮義，喜歡音樂。

		  if($self->has_stars(  stars=>["文昌","文曲"]) ){
		       push @{$res->{$k}->{"additional"} },qq|好禮義，喜歡音樂。|;
		  }
# 命宮有：擎羊、陀羅、火星、鈴星、空劫、天刑，時常有不測之災禍，或因病災動手術而身體不適。
		  if($self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星","空劫","天刑"]) ){
		       push @{$res->{$k}->{"additional"} },qq|時常有不測之災禍，或因病災動手術而身體不適。|;
		  }


	      }
		################   天府   ####################  
		if($k eq "天府"){
		   $res->{$k}->{"main"}.= qq|

 容貌：額方顎圓、唇紅牙白。

性格：心性溫和、聰明清秀。學多機變、頗有才能。

人格類型：領導型 (管理控制力)。

個性特質：財富、守成、保守、安定、佈施、管理 、才能豐富、慈悲、尊貴、厚重。判斷須加以控制的事物及維持整個事物進行過程中的控制。

愛情：冷靜理性。

優點：心地寬厚，不拘小節，天性樂觀，熱心助人，不爭名利，自由愜意。
缺點：大而化之，隨遇而安，缺少衝勁，貪歡享受，欠缺魄力，耐性不足。

象徵財庫的星曜。能給人一種可靠及包容的感覺，喜歡傾聽朋友吐露心事，同時也愛照顧弱小的人，給人值得信賴的感覺。為人較為保守，缺少主動性，屬於外柔內剛聰明機伶型，講原則，適應力強，有學習的天份，很愛面子，喜歡有自己的思想主張，工作也能按步就班來完成，利於守成，不利開創，喜歡在平穩中成長。穩重大方，溫和善良，有規則有操守，氣質高雅！盡忠職守，負責任，任勞任怨，是非常優秀的輔佐人才，亦擁有著領導的才能與氣質！但有時又顯現缺乏企圖心，作風保守墨守成規，性情略帶優柔寡斷，做事有太多的盤算及計較，因此會讓人誤解其自私與現實。天府星對煞星有管束之力，最怕天空、地劫，地劫尤甚。對金錢的追逐或是管理有一套自己的哲理，本身的儲蓄能力不錯，講究生活品味，喜歡高雅的生活。找老婆以命宮有天府者 較為理想。

		      溫文儒雅，風度翩翩，為財帛之主。
		      性外和內剛，有爭權奪利之心，高傲。保守、穩重，不喜競爭，但對自己信心十足。有專長，但專長較大眾化。
		      身態：形貌清秀，面紅齒白；心性溫和善良，聰明機智，安分守己，具有學習之天才。
		      個性：喜歡命令他人，不喜歡受他人約束。有領導統御、企劃組織、處理財務之長才。
		      有爭權力，與人計較利益之缺點，不認輸，注意小細節。
		      喜歡學習新事物，對於目標非常執著。懂得積財、理財，因此比較有錢。缺乏開創力，但擅於守成。
		      	


	|;

			if( $self->born(  time=>["巳","亥"] ) ){
			     push @{$res->{$k}->{"additional"} },qq|主貴。|;
			}

  		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 天府臨戌有星扶，腰金衣紫。（甲己生人會吉，無煞湊）
			if( $self->born(  time=>["戌"] )  && !$self->has_sixghost() ){
			     push @{$res->{$k}->{"additional"} },qq|腰金衣紫|;
			}
			if( $self->born(  time=>["甲","己"] )  && $self->has_sixlucky() && !$self->has_sixghost() ){
			     push @{$res->{$k}->{"additional"} },qq|腰金衣紫|;
			}

# ＊ 天府戌宮無煞湊，甲己人腰金又且富。（加四煞有疵）
			if( $self->born(  time=>["戌"] ) && !$self->has_sixghost() ){
			     push @{$res->{$k}->{"additional"} },qq|腰金又且富。|;
			}

# ＊ 天府居午，戌宮天相來朝，甲生人一品之貴。
			if( $self->born(  time=>["午","戌"] ) && $self->born(  time=>["甲"] ) && $self->has_stars(  stars=>["天相"])  ){
			     push @{$res->{$k}->{"additional"} },qq|一品之貴。|;
			}


# ＊ 府相同來會命宮，千鐘食祿。（安命寅申宮，府相在財帛官祿宮輔者上格，為府相朝垣格。別宮次之）
		  if($self->has_stars(  stars=>["天相","天同"]) ){
		       push @{$res->{$k}->{"additional"} },qq|千鐘食祿|;
		  }

# ＊ 天府武曲祿存，必有巨萬之富。
		  if($self->has_stars(  stars=>["武曲","祿存"]) ){
		       push @{$res->{$k}->{"additional"} },qq|必有巨萬之富。|;
		  }
# ＊ 天府昌曲左右，高第恩榮。
		  if($self->has_stars(  stars=>["文昌","文曲","左輔","右弼"]) ){
		       push @{$res->{$k}->{"additional"} },qq|高第恩榮。|;
		  }

# ＊ 左府同宮，尊居萬乘。
		  if($self->has_stars(  stars=>[ "左輔"]) ){
		       push @{$res->{$k}->{"additional"} },qq|尊居萬乘。|;
		  }

# ＊ 天府守命，羊陀火鈴會合，主人奸詐。
		  if($self->has_jiahui(  stars=>[ "擎羊","陀羅","火星","鈴星"]) ){
		       push @{$res->{$k}->{"additional"} },qq|主人奸詐。|;
		  }
# ＊ 天府天相，乃為衣祿之神，為仕為官，定主亨通之兆。
		  if($self->has_stars(  stars=>[ "天相"]) ){
		       push @{$res->{$k}->{"additional"} },qq|乃為衣祿之神，為仕為官，定主亨通之兆。|;
		  }

# ＊ 天府代表慈悲，現實。
		       push @{$res->{$k}->{"additional"} },qq|代表慈悲，現實。|;
# ＊ 天府是財庫星，命宮有天府，多有儲蓄，跟會習慣。
		       push @{$res->{$k}->{"additional"} },qq|多有儲蓄，跟會習慣。|;
# ＊ 天府善積錢財，理財，購置田產。
		       push @{$res->{$k}->{"additional"} },qq|善積錢財，理財，購置田產。|;

# ＊ 天府女命得之，旺夫益子，任何職務都能負責盡職。
		  if( $you->{sex} eq 1 ){
		       push @{$res->{$k}->{"additional"} },qq|旺夫益子，任何職務都能負責盡職。|;
		  }
# ＊ 天府加會左輔、右弼，有能力，可掌大權，為人企劃組織力佳，有貴人助。
		  if($self->has_jiahui(  stars=>[ "左輔","右弼"]) ){
		       push @{$res->{$k}->{"additional"} },qq|有能力，可掌大權，為人企劃組織力佳，有貴人助。|;
		  }
# ＊ 天府加會文昌、文曲，有文采，有風度，才華洋溢。
		  if($self->has_jiahui(  stars=>[ "文昌","文曲"]) ){
		       push @{$res->{$k}->{"additional"} },qq|有文采，有風度，才華洋溢。|;
		  }

# ＊ 天府加會天魁、天鉞，有貴人相助。
		  if($self->has_jiahui(  stars=>[ "天魁","天鉞"]) ){
		       push @{$res->{$k}->{"additional"} },qq|有貴人相助。|;
		  }

# ＊ 天府加會科、權、祿，工作順利，運勢佳。
		  if($self->has_jiahui_huaji( star=>$k, stars=>[ "科","權","祿"] )   ){
		       push @{$res->{$k}->{"additional"} },qq|工作順利，運勢佳。|;
		  }
# ＊ 天府加會火星或鈴星多耗財。 
		  if($self->has_jiahui(  stars=>[ "火星"]) || $self->has_jiahui(  stars=>[ "鈴星"])  ){
		       push @{$res->{$k}->{"additional"} },qq|多耗財。 |;
		  }
# ＊ 天府加會擎羊、陀羅不重錢財，財來財去。
		  if($self->has_jiahui(  stars=>[ "擎羊","陀羅"]) ){
		       push @{$res->{$k}->{"additional"} },qq|不重錢財，財來財去。|;
		  }
# ＊ 天府加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌，不重錢財，易患感冒小病不斷。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|不重錢財，易患感冒小病不斷。|;
		  }
# ＊ 大小限遇天府星想當老闆有意外之財運。

# ＊ 府相同來會命宮，千鐘食祿。（安命寅申宮，府相在財帛官祿宮輔者上格，為府相朝垣格。別宮次之）
# ＊ 安命寅宮，府午宮，相戌宮來朝，位登一品之榮。（甲生人遇之亦佳）
# ＊ 天府武曲居財宅，更兼權祿富奢翁。（有左右祿存亦美）
# ＊ 天府守命，忌落空亡，主人孤立。
# ＊ 天府乃南斗星；衣祿之神，財帛宮主、田宅宮主。


# 命宮有：祿存，名利雙收。
		  if($self->has_stars(  stars=>["祿存"]) ){
		       push @{$res->{$k}->{"additional"} },qq|名利雙收。|;
		  }

# 命宮有：文曲、文昌、左輔、右弼，才學佳、考試運好。
		  if($self->has_stars(  stars=>["文曲","文昌","左輔","右弼"])){
		       push @{$res->{$k}->{"additional"} },qq|才學佳、考試運好。|;
		  }

# 命宮有：擎羊、陀羅、火星、鈴星，如無吉星輔曜扶持，則為人善於計謀好詐。
		  if($self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星"] )&& !$self->has_sixlucky() ){
			     push @{$res->{$k}->{"additional"} },qq|如無吉星輔曜扶持，則為人善於計謀好詐。|;

		  }

# 命宮有：天空、地劫，主孤獨、福不全。
		  if($self->has_stars(  stars=>["天空","地劫"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|主孤獨、福不全。|;
		  }

# 命宮有：天姚，主權術陰謀之士。
		  if($self->has_stars(  stars=>["天姚"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|主權術陰謀之士。|;
		  }

# 女命清秀、高雅，理智重於感情，有獨特的審美觀念，重穿著，喜佈置居家環境。
		    if( $you->{sex} eq 1 ){
		       push @{$res->{$k}->{"additional"} },qq|女命清秀、高雅，理智重於感情，有獨特的審美觀念，重穿著，喜佈置居家環境。|;
		  }


	      }
		################   太陰   ####################  
		if($k eq "太陰"){
		   $res->{$k}->{"main"}.= qq|
 容貌：清秀優雅、斯斯文文。

性格：聰明博學、花酒文章。雖為聰明、頗有潔癖。

人格類型：合作型 (反應力)。

個性特質：貞潔、浪漫、清潔、內斂、圓滑 、潔癖、花酒、財富、田財。能給予其它人的需求正面及有效的評價。

愛情：嬌柔婉約。

優點：按部就班，要求完美，個性謙虛，待人和氣，合群性強，勇於負責，喜歡學習研究，處世平穩妥善。
缺點：多愁善感，逃避現實，缺少自信，優柔寡斷，顧影自憐，容易悲觀，情緒波折起伏，常受意見困擾。

			  太陰星本身是田宅宮的宮主，主靜，主收歛，象徵「富」的現象。貞潔。母親的代表。喜詩情畫意，愛幻想。相當體貼而斯文，善解人意，加上配合性高，是團體生活中很容易被接受的人。顧家。凡是小心，甚至有點吹毛求疵，有點潔癖。喜歡穩定。優柔寡斷，晚發。夜生人易得福氣，喜在申酉戌亥子丑宮，忌入寅卯辰巳午未宮。女性入命宮則是標準女性，有女性美，男命則失之，魄力不足。男命逢太陰化忌，容易形成同性戀。也是談情說愛之星，限逢利談婚事。化忌時較容易會有失戀、單戀之應。太陰星的人，最喜歡把積蓄拿去買些浪漫的事物上。而在愛情這條路上的選擇可說是蠻多樣性的。


			為田宅主。
			聰明清秀，心性溫和，度量寬宏，博學多能，很愛乾淨。刑克：刑克陰性近親，主要為親情不足或長期健康不佳。職業：易接近清高工作，如研究、學術、考試、文藝、公職等。疾病：無論在命宮或疾厄宮，均主易犯與泌尿有關疾病。宮位廟旺宮位能伸能守，有利公職、文化藝術，落陷宮位開運遲或力不從心，就業保守反而能維持和祥，太過競爭性的不適合。
			身態：面色青白或略帶黃黑，臉型較圓長或略帶微方的面型。
			個性：為人性情內向，聰明俊秀，善用心計。多思多慮、溫和耿直、態度端莊凝重。
		  

		      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
		  if($you->{ziwei}->{"太陰"}->{bright} eq "陷" ){
		       push @{$res->{$k}->{"additional"} },qq|多神經質。|;

		  }
# 
# ＊ 太陰守命，廟見諸吉，富且貴。
		  if($you->{ziwei}->{"太陰"}->{bright} eq "廟" && $self->has_sixlucky() ){
		       push @{$res->{$k}->{"additional"} },qq|富且貴。|;

		  }

# ＊ 太陰守命，夜生人不宜陷，陷則克母，男且克妻。 （太陽在申酉戌亥子，乃為失輝。太陰在卯辰巳午未，乃為失輝）
		  if(!$you->{ziwei}->{"太陰"}->{bright} eq "陷" && $self->born(  time=>["卯","辰","巳","午","未"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|克母，男且克妻。|;

		  }

# ＊ 太陰在命身宮，廟旺，主一生快樂。
		  if($you->{ziwei}->{"太陰"}->{bright} eq "廟" || $you->{ziwei}->{"太陰"}->{bright} eq "旺"){
		       push @{$res->{$k}->{"additional"} },qq|主一生快樂。|;

		  }

# ＊ 太陰守命，落陷，化吉科權祿返凶，出外離祖吉，更遇四煞，酒色邪淫，下賤夭折。
		  if($you->{ziwei}->{"太陰"}->{bright} eq "陷" && $self->has_jiahui_huaji( star=>$k, stars=>[ "科","權","祿"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|返凶，出外離祖吉|;
		      if($self->has_fourghost()){
		       push @{$res->{$k}->{"additional"} },qq|酒色邪淫，下賤夭折。|;
		      }
		  }

# ＊ 太陰守命，落陷，與羊陀火鈴同宮，肢體傷殘。
		  if($you->{ziwei}->{"太陰"}->{bright} eq "陷" && $self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|肢體傷殘。|;

		  }

# ＊ 太陰居子，號曰水澄桂萼，得清要之職，忠諫之才。
			if( $self->born(  time=>["子"] ) ){
			     push @{$res->{$k}->{"additional"} },qq|號曰水澄桂萼，得清要之職，忠諫之才。|;
			}


# ＊ 太陰居子，丙丁生人，富貴忠良。
			if( $self->born(  time=>["子"] ) &&  $self->born(  time=>["丙","丁"] ) ){
			     push @{$res->{$k}->{"additional"} },qq|富貴忠良。|;
			}

# ＊ 太陰與天機昌曲同宮於寅，男為僕從女為妓。
		  if($self->born(  time=>["寅"] ) &&  $self->has_stars(  stars=>["天機","文昌","文曲"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|男為僕從女為妓。|;

		  }
# ＊ 太陰在戌守命，太陽在辰對照，主富貴。
		  if($self->born(  time=>["戌"] ) &&  $self->has_stars( pos=>$self->position(time=>["辰"]), stars=>["太陽"])  ){
		       push @{$res->{$k}->{"additional"} },qq|主富貴。|;

		  }
# ＊ 太陰祿存同宮，左右相逢富貴翁。
		  if($self->has_stars(  stars=>["祿存"] ) && $self->has_jiagong(  stars=>["左輔","右弼"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|富貴翁。|;

		  }

# ＊ 太陰文曲同宮，定是九流術士。
		  if($self->has_stars(  stars=>["文曲"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|定是九流術士。|;

		  }
# ＊ 陰陽會昌曲，出世榮華。（命坐日月，財官二宮昌曲來會。或命坐昌曲，財官二宮日月來會。再遇魁鉞吉星，主富貴）
		  if($self->has_stars(  stars=>["太陽"] ) && $self->has_jiahui(  stars=>["文昌","文曲"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|出世榮華。|;
		    if( $self->has_jiahui(  stars=>[ "天魁","天鉞" ] )){
		       push @{$res->{$k}->{"additional"} },qq|主富貴|;

		    }

		  }


# ＊ 太陰羊陀，必主人離財散。
		  if($self->has_stars(  stars=>["擎羊","陀羅"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|必主人離財散。|;

		  }
# ＊ 日月最嫌反背，乃為失輝。（太陽在申酉戌亥子，乃為失輝。太陰在卯辰巳午未，乃為失輝）
		  if($self->born(  time=>["卯","辰","巳","午","未"] )){
		       push @{$res->{$k}->{"additional"} },qq|為失輝|;

		  }
# ＊ 月曜、天梁女淫貧。（太陰寅申宮，天梁巳亥宮，女命值之，多主淫貧，或偏房侍妾）
		  if($self->born(  time=>["寅","申"] ) &&  $self->has_stars( pos=>$self->position(time=>["巳","亥"]), stars=>["天梁"])){
		       push @{$res->{$k}->{"additional"} },qq|女命值之，多主淫貧，或偏房侍妾|;

		  }
# ＊ 太陰代表清潔，錢財，田產。
		       push @{$res->{$k}->{"additional"} },qq|代表清潔，錢財，田產。|;

# ＊ 太陰以卯辰已午未為失輝，以酉戍亥子丑為廟旺，代表有福，會享受，找快樂，重感情，失輝必凶，力不從心，膽子小，感情不順。
		  if($self->born(  time=>["酉","戍","亥","子","丑"] )){
		       push @{$res->{$k}->{"additional"} },qq|代表有福，會享受，找快樂，重感情。|;

		  }else{
		       push @{$res->{$k}->{"additional"} },qq|失輝必凶，力不從心，膽子小，感情不順。|;
		  }
# ＊ 太陰廟旺，代表富貴。
		  if($you->{ziwei}->{"太陰"}->{bright} eq "廟" || $you->{ziwei}->{"太陰"}->{bright} eq "旺"){
		       push @{$res->{$k}->{"additional"} },qq|富貴。|;

		  }
# ＊ 太陰代表母親，又作妻星但太陰失輝則受制不吉代表與母親緣薄或代溝。
		  if($self->born(  time=>["卯","辰","巳","午","未"] )){
		       push @{$res->{$k}->{"additional"} },qq|受制不吉代表與母親緣薄或代溝。|;

		  }

# ＊ 太陰廟旺善積錢財，購置田產。


		  
		  if($you->{ziwei}->{"太陰"}->{bright} eq "廟" || $you->{ziwei}->{"太陰"}->{bright} eq "旺"){
		       push @{$res->{$k}->{"additional"} },qq|善積錢財，購置田產。|;

		  }
# ＊ 太陰失輝勤儉剋苦存錢，購置田產。
		  if($self->born(  time=>["卯","辰","巳","午","未"] )){
		       push @{$res->{$k}->{"additional"} },qq|勤儉剋苦存錢，購置田產。|;

		  }

# ＊ 太陰廟旺加會左輔，右弼，有福氣，有管理能力，有貴人助。
		  if($self->has_jiahui(  stars=>["左輔","右弼"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|有福氣，有管理能力，有貴人助。|;	  
		  }
# ＊ 太陰失輝加會左輔，右弼，競競業業，為人隨和，自助人助。
		  if($self->born(  time=>["卯","辰","巳","午","未"] ) && $self->has_jiahui(  stars=>["左輔","右弼"] )){
		       push @{$res->{$k}->{"additional"} },qq|競競業業，為人隨和，自助人助。|;

		  }
		  
# ＊ 太陰加會天魁，天鉞，宜公家機關，有貴人相助。
		  if($self->has_jiahui(  stars=>["天魁","天鉞"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|宜公家機關，有貴人相助。|;	  
		  }
# ＊ 太陰化祿：太陰廟旺主財源不斷，太陰失輝主辛勤得財。
		  if(($you->{ziwei}->{"太陰"}->{bright} eq "廟" || $you->{ziwei}->{"太陰"}->{bright} eq "旺" )&&   $self->has_huaji( star=>$k, stars=>[ "祿"] )){
		       push @{$res->{$k}->{"additional"} },qq|主財源不斷。|;
			  if($self->born(  time=>["卯","辰","巳","午","未"] )){
			      push @{$res->{$k}->{"additional"} },qq|主辛勤得財。|;

			  }
		  
		  }
		  
# ＊ 太陰化權：太陰廟旺管理能力佳，有鬥志，創業心，會享受，太陰失輝勞碌命，無福享受。
		  if(($you->{ziwei}->{"太陰"}->{bright} eq "廟"|| $you->{ziwei}->{"太陰"}->{bright} eq "旺") &&   $self->has_huaji( star=>$k, stars=>[ "權"] )){
		       push @{$res->{$k}->{"additional"} },qq|管理能力佳|;
			  if($self->born(  time=>["卯","辰","巳","午","未"] )){
			      push @{$res->{$k}->{"additional"} },qq|勞碌命，無福享受。|;

			  }
		  
		  }
# ＊ 太陰化科：學術研究、有名聲、賺佣金、暗財。
		  if( $self->has_huaji( star=>$k, stars=>[ "科"] )){
		       push @{$res->{$k}->{"additional"} },qq|學術研究、有名聲、賺佣金、暗財。|;

		  }
# ＊ 太陰化忌：易吃暗虧、財源短缺、為房子操煩。
		  if( $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|易吃暗虧、財源短缺、為房子操煩。|;

		  }
# ＊ 太陰加會科、權、祿，財源滾滾，名聲佳，運勢亨通。
		  if( $self->has_jiahui_huaji( star=>$k, stars=>[ "科","權","祿"] )){
		       push @{$res->{$k}->{"additional"} },qq|財源滾滾，名聲佳，運勢亨通。|;

		  }
# ＊ 太陰加會火星或鈴星感情困擾，多耗財，因災禍受傷。
		  if($self->has_jiahui(  stars=>["火星"] ) || $self->has_jiahui(  stars=>[ "鈴星"]) ){
		       push @{$res->{$k}->{"additional"} },qq|感情困擾，多耗財，因災禍受傷。|;

		  }
		  
# ＊ 太陰加會擎羊、陀羅防頭部受傷，不利妻子。
		  if($self->has_jiahui(  stars=>["擎羊","陀羅"] )){
		       push @{$res->{$k}->{"additional"} },qq|防頭部受傷，不利妻子。|;

		  }
# ＊ 太陰加會火星、鈴星、擎羊、陀羅，地空、地劫、化忌，易失戀，易小病不斷。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|易失戀，易小病不斷。|;

		  }
# ＊ 大小限遇太陰星主戀愛，名望，置產運。
# ＊ 月朗天門於亥地，進爵封侯。（為月朗天門之格。子年生人，夜生者合局，不貴則大富。丙丁生人主貴，壬癸生人主富，亦要三方吉拱）
# ＊ 陰陽會昌曲，出世榮華。（命坐日月，財官二宮昌曲來會。或命坐昌曲，財官二宮日月來會。再遇魁鉞吉星，主富貴）
# ＊ 太陰同文曲于妻宮，蟾宮折桂之榮。（文昌亦然。在命身宮則為巧藝之人）
# ＊ 太陰居財帛，多為財賦之官。
# ＊ 太陰居疾厄，遇陀羅，主目疾。遇火鈴，為災。
# ＊ 太陰為田宅宮主，居田宅宮為得位，主田產多。
# ＊ 太陰在身宮逢之，主隨娘繼拜或離祖過房。

# 命宮有：文昌、文曲，有文藝才華。
		  if($self->has_stars(  stars=>["文昌","文曲"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|有文藝才華。|;
		  }
# 命宮有：天魁、天鉞，服公職、平安順利。
		  if($self->has_stars(  stars=>["天魁","天鉞"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|服公職、平安順利。|;
		  }
# 命宮有：祿存及三台及八座，聲名佳。
		  if($self->has_stars(  stars=>["祿存","三台","八座"] )  ){
		       push @{$res->{$k}->{"additional"} },qq|聲名佳。|;
		  }
# 命宮有：祿存及左輔及右弼，一生有錢、有福。
		  if($self->has_stars(  stars=>["祿存","左輔","右弼"] ) ){
		       push @{$res->{$k}->{"additional"} },qq|一生有錢、有福。|;
		  }
# 女命太陰的旺度為廟，夫人之格，為人端莊凝重，聰明敏感，重情感，助夫教子之命。

		  if( $you->{sex} eq 1 ){
			  if($you->{ziwei}->{"太陰"}->{bright} eq "廟" ){
			     push @{$res->{$k}->{"additional"} },qq|夫人之格，為人端莊凝重，聰明敏感，重情感，助夫教子之命。|;
			  }

# 命宮有：擎羊、陀羅、火星、鈴星、天刑、空劫，容易傷夫剋子。
			  if($self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星","天刑","空劫"] ) ){
			      push @{$res->{$k}->{"additional"} },qq|容易傷夫剋子。|;
			}	   

# 命宮有：天姚、咸池、文昌、文曲，宜為繼室、偏房為宜，否則性浮蕩、不安於家室。
			  if($self->has_stars(  stars=>["天姚","咸池","文昌","文曲"] ) ){
			      push @{$res->{$k}->{"additional"} },qq|宜為繼室、偏房為宜，否則性浮蕩、不安於家室。|;
			}	   

		  }
	      }

		################   貪狼   ####################  
		if($k eq "貪狼"){
		   $res->{$k}->{"main"}.= qq|
 容貌：眉股高露、耳廓反出。

性格：性格不常、心多計較。謂顧現實、難免多愁。

人格類型：開創型 (冒險精神)。

個性特質：慾望、吸收、交際、投機、好奇 、物質、佔有、官非、邪惡、凶狠、爭烈、應酬。有估計及邏輯思考能力去面對困難、挑戰。

愛情：豪氣大膽。

優點：多才多藝，靈敏機巧，善於交際，學習力強，足智多謀，野心十足，生活多采多姿，常得異性助力。
缺點：貪多騖得，不喜深入，任性倔強，缺少恆心，喜新厭舊，多學少精，貪歡享受，慾望強。


		      為慾望、放蕩、大桃花、多才多藝之星，重感情，貪酒色，現實多慾，貪圖不厭，好動圓滑，八面玲瓏。具有多重人格，聰明、細心。適合往演藝路線發展。注重人際關係。相當愛好自由，不喜拘束。貪狼所在的宮位，常為慾望之所在。是一顆足智多謀的星曜，象徵「桃花」的現象，是第一大桃花星，喜好文藝，能言善道，勇於表現自我，生性熱情活潑，嘴真是超甜的，常為身邊四周 的人帶來活力。貪狼也是交際應酬之能手，男命則愛流連於江湖花酒，女命不易滿足於一個交往對象。因為是桃花星，異性緣極好，逢場作戲機率高。此星富極強之生命力，能夠吃苦耐勞，人命逢之，主其人慾望頗強，注重現實，愛憎無常，私心吝嗇。亦是修道星，晚年容易往修道方面走。存錢的觀念比較差，有著享樂主義的精神。 此外，對美的感受力強，所以在外表上也會蠻重視的，也是蠻重視物質生活的一群。化祿加深物慾，化忌削減慾望。

\		      具才藝而帶桃花。
		      性格都比較複雜，不安定，好動，善於交際應酬。多才多藝，且嗜酒好賭，應酬較多，如往演藝界發展有利。容易在工作中遇到競爭，且本身也喜歡競爭。一生易有大幅度變化，以環境及感情居多。對六煞、化忌有抵制力，能使其本身由嗜聲色而轉向才藝發揮。
		      身態：人面色青白或略帶黃色，中等身材，是理想主義或完美主義者。
		      個性：不拘小節，浪蕩形骸，生活多彩多姿，喜吃喝、愛過夜生活，善交際應酬。能言善道、作事明快、不畏辛苦、敢賺敢花。感情不定、複雜，有博愛之病。為人隨和，特別關懷異性。尤以入水鄉者，水性楊花。善體人意，又會駕馭人。喜歌藝、也善歌藝，又好神仙之學。博學不精，才藝盡通但不精。

|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
		  if($you->{ziwei}->{"貪狼"}->{bright} eq "廟" ){
		      push @{$res->{$k}->{"additional"} },qq|身材肥胖高大。|;
		   }

# ＊ 貪狼入廟，辰戌丑未宮坐命，或落空亡，反能習正。
		  if($you->{ziwei}->{"貪狼"}->{bright} eq "廟" && $self->born(  time=>["戌","辰","丑","未"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|或落空亡，反能習正。|;
		   }

# ＊ 貪狼加吉坐長生，壽考永無彭祖。（貪狼守命，加吉，坐長生于寅申巳亥四宮，主壽）
			  if($self->has_sixlucky() ){
			      push @{$res->{$k}->{"additional"} },qq|長生，壽考永無彭祖。|;
			      if($self->born(  time=>["寅","申","巳","亥"] ) ){
				  push @{$res->{$k}->{"additional"} },qq|主壽。
				  |;
			      }
			    
			}	

# ＊ 貪狼入廟壽元長。
		  if($you->{ziwei}->{"貪狼"}->{bright} eq "廟"  ){
		      push @{$res->{$k}->{"additional"} },qq|壽元長。|;
		   }
# ＊ 貪狼子午卯酉宮守命，終身不能有為。（寅午戌生人命坐午宮，申子辰生人命坐子宮，巳酉丑生人命坐酉宮，亥卯未生人命坐卯宮）
		if($self->born(  time=>["子","午","卯","酉"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|終身不能有為。
		    |;
		}

# ＊ 貪會旺宮，終身鼠竊。
		  if($you->{ziwei}->{"貪狼"}->{bright} eq "旺"  ){
		      push @{$res->{$k}->{"additional"} },qq|終身鼠竊。|;
		   }
# ＊ 貪狼紫微同宮，如無制，是無益之人。（得輔弼昌曲夾制，則無此論）
		    if($self->has_stars(  stars=>["紫微"] ) && !$self->has_jiagong(  stars=>["左輔","右弼","文昌","文曲"] )){
			push @{$res->{$k}->{"additional"} },qq|如無制，是無益之人。|;
		  }	   
# ＊ 貪狼武曲同宮，為人諂佞奸貪，自私自利，無公德心。
		    if($self->has_stars(  stars=>["武曲"] )){
			push @{$res->{$k}->{"additional"} },qq|為人諂佞奸貪，自私自利，無公德心。|;
		  }	   

# ＊ 貪狼武曲同宮，先貧而後富。（利己損人。命有紫微日月左右昌曲拱照，限逢祿權科，則貴顯論）
		    if($self->has_stars(  stars=>["武曲"] )){
			push @{$res->{$k}->{"additional"} },qq|先貧而後富。利己損人。|;
		       if($self->has_shanhe(  stars=>["紫微","太陽","太陰","左輔","右弼","文昌","文曲"] ) || $self->has_huaji( star=>$k, stars=>[ "祿","權","科"] ) ){
			      push @{$res->{$k}->{"additional"} },qq|限逢祿權科 則貴顯論|;
			}
		  }	   
# ＊ 貪武墓中居，三十才發福。（為貪武同行格）****
		    if($self->has_stars(  stars=>["武曲"] )){
			      push @{$res->{$k}->{"additional"} },qq|三十才發福。|;
			}
# ＊ 貪狼武曲同守身，無吉命反不長。（命無吉曜，身有貪武，孤貧）
		    if($self->has_stars(  stars=>["武曲"] ) && !($self->has_sixlucky())){
			      push @{$res->{$k}->{"additional"} },qq|命反不長。孤貧。|;
		}

# ＊ 貪武破軍無吉曜，迷戀花酒以亡身。（或作手藝）
		    if($self->has_stars(  stars=>["破軍"] ) && !($self->has_sixlucky())){
			      push @{$res->{$k}->{"additional"} },qq|迷戀花酒以亡身。（或作手藝）|;
		}
# ＊ 貪狼廉貞同宮，男浪蕩，女多淫，酒色喪身。
		    if($self->has_stars(  stars=>["廉貞"] ) ){
			      push @{$res->{$k}->{"additional"} },qq|男浪蕩，女多淫，酒色喪身。|;
		}

# ＊ 貪狼廉貞同宮於巳亥，不純潔且遭官刑。
		    if($self->has_stars(  stars=>["廉貞"] ) && $self->born(  time=>["巳","亥"] )){
			      push @{$res->{$k}->{"additional"} },qq|不純潔且遭官刑。|;
		}

# ＊ 貪狼陷地，加羊陀忌星，孤貧破相殘疾，有斑痕疤痣。
		  if($you->{ziwei}->{"貪狼"}->{bright} eq "陷" && $self->has_stars(  stars=>["擎羊","陀羅"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|孤貧破相殘疾，有斑痕疤痣。|;
		   }

# ＊ 貪狼巳亥陷地加煞，不為屠人亦遭刑。
		  if($you->{ziwei}->{"貪狼"}->{bright} eq "陷" && $self->born(  time=>["巳","亥"] )   ){
		      push @{$res->{$k}->{"additional"} },qq|不為屠人亦遭刑。|;
		   }
# ＊ 貪狼加煞同鄉，女偷香而男鼠竊。
		    if($self->has_sixghost()){
			      push @{$res->{$k}->{"additional"} },qq|女偷香而男鼠竊。|;
		}
# ＊ 貪狼會煞無吉曜，屠宰之人。
		    if($self->has_jiahui(  stars=>@sixghosts )&&  !($self->has_sixlucky())){
			      push @{$res->{$k}->{"additional"} },qq|屠宰之人。|;
		}

# ＊ 貪狼擎羊居午位，丙戊生人鎮邊疆。（為馬頭帶箭格，富而且貴）
		  if($self->born(  time=>["午"] )  &&$self->born(  time=>["丙","戊"] )  && $self->has_stars(  stars=>["擎羊"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|鎮邊疆。（為馬頭帶箭格，富而且貴）|;
		   }

# ＊ 貪狼火星居廟旺，名振諸邦。（辰戌丑未安命，三方吉拱尤美。卯宮安命，無煞次之。加羊陀空劫不合此格）
		  if($self->has_stars(  stars=>["火星"] ) && !$self->has_stars(  stars=>["擎羊","陀羅"] ) &&  ($you->{ziwei}->{"貪狼"}->{bright} eq "旺" || $you->{ziwei}->{"貪狼"}->{bright} eq "廟")  ){
		      push @{$res->{$k}->{"additional"} },qq|名振諸邦。（辰戌丑未安命，三方吉拱尤美。卯宮安命，無煞次之。加羊陀空劫不合此格）|;
		   }

# ＊ 貪鈴並守，將相之名。（辰戌丑未子宮安命，加吉，戊己生人合格）
		  if($self->has_stars(  stars=>["鈴星"] ) && $self->born(  time=>["辰","戌","丑","未","子","己"] ) && $self->has_sixlucky() ){
		      push @{$res->{$k}->{"additional"} },qq|將相之名。（辰戌丑未子宮安命，加吉，戊己生人合格）|;
		   }

# ＊ 貪狼羊陀同宮，為屠宰。（在午宮不是）
		  if($self->has_stars(  stars=>["擎羊","陀羅"] ) && !$self->born(  time=>["午"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|為屠宰。（在午宮不是）|;
		   }

# ＊ 貪狼亥子遇羊陀，為名泛水桃花。（男女貪花迷酒喪身，有吉曜則吉）
		  if($self->has_stars(  stars=>["擎羊","陀羅"] ) && $self->born(  time=>["亥","子"] ) && !$self->has_sixlucky()  ){
		      push @{$res->{$k}->{"additional"} },qq|為名泛水桃花。（男女貪花迷酒喪身，有吉曜則吉）|;
		   }

# ＊ 貪狼陀羅在寅宮，號曰風流彩杖。
		  if($self->has_stars(  stars=>["陀羅"] ) && $self->born(  time=>["寅"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|號曰風流彩杖。|;
		   }
# ＊ 貪狼昌曲同宮，必多虛而少實。
		  if($self->has_stars(  stars=>["文昌","文曲"] )   ){
		      push @{$res->{$k}->{"additional"} },qq|必多虛而少實。|;
		   }
# ＊ 女命，貪狼在亥子遇羊陀，多嫉妒。（逢祿馬不美）
		  if( $you->{sex} eq 1 ){
		      if($self->has_stars(  stars=>["擎羊","陀羅"] ) &&  $self->born(  time=>["亥","子"] )  ){
			  push @{$res->{$k}->{"additional"} },qq|多嫉妒。（逢祿馬不美）|;
		      }
	  # ＊ 女命，貪狼巳亥陷地守命，加煞，必為娼妓。
			if( $self->born(  time=>["巳","亥"] ) &&  $you->{ziwei}->{"貪狼"}->{bright} eq "陷" && $self->has_sixghost() ){
			    push @{$res->{$k}->{"additional"} },qq|必為娼妓。|;
			}
		  }
# ＊ 貪狼代表桃花，禍福。
			    push @{$res->{$k}->{"additional"} },qq|桃花，禍福。|;
# ＊ 貪狼為北斗星，教化之星，禍福之神，桃花星，博愛星，長壽星。
			    push @{$res->{$k}->{"additional"} },qq|北斗星，教化之星，禍福之神，桃花星，博愛星，長壽星。|;
# ＊ 貪狼遇吉則主富貴，遇凶則主虛浮。
		  if($self->has_sixlucky()  ){
		      push @{$res->{$k}->{"additional"} },qq|主富貴。|;
		   }else{
		      push @{$res->{$k}->{"additional"} },qq|主虛浮。|;
		  }

# ＊ 貪狼性剛威猛，隨波逐浪，愛憎難定。
		      push @{$res->{$k}->{"additional"} },qq|性剛威猛，隨波逐浪，愛憎難定。|;
# ＊ 貪狼化祿：善交際，善體人意，有人緣，有偏財。
		  if( $self->has_huaji( star=>$k, stars=>[ "祿"] )){
		       push @{$res->{$k}->{"additional"} },qq|善交際，善體人意，有人緣，有偏財。|;

		  }

# ＊ 貪狼化權：有作為，會交際，有桃花，有偏財。
		  if( $self->has_huaji( star=>$k, stars=>[ "權"] )){
		       push @{$res->{$k}->{"additional"} },qq|有作為，會交際，有桃花，有偏財。|;

		  }

# ＊ 貪狼化忌：不實際，空想多，享受情慾，好賭，感情不穩定。
		  if( $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|不實際，空想多，享受情慾，好賭，感情不穩定。|;

		  }
# ＊ 貪狼加會左輔、右弼：敢賺敢花，管理能力強，善應酬交際。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|敢賺敢花，管理能力強，善應酬交際。|;
		  }

# ＊ 貪狼加會文昌、文曲：言語誇張，計劃多不周詳，反應靈活，善察言觀色，感情不定，博學多能。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|言語誇張，計劃多不周詳，反應靈活，善察言觀色，感情不定，博學多能。|;
		  }
# ＊ 貪狼加會天魁、天鉞：人緣好，桃花佳，有貴人相助。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|人緣好，桃花佳，有貴人相助。|;
		  }

# ＊ 貪狼加會科、權、祿：桃花財源滾滾，食祿佳，長壽，運勢亨通。
		  if( $self->has_jiahui_huaji( star=>$k, stars=>[ "科","權","祿"] )){
		       push @{$res->{$k}->{"additional"} },qq|桃花財源滾滾，食祿佳，長壽，運勢亨通。|;

		  }

# ＊ 貪狼加會火星或鈴星有暴發機運，從商者機運到，發意外財。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>[ "鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|有暴發機運，從商者機運到，發意外財。|;
		  }
# ＊ 貪狼加會擎羊、陀羅防頭部或下半身疾病，體質不良。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|防頭部或下半身疾病，體質不良。|;
		  }
# ＊ 貪狼加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌，感情問題多，生活較沒有目標。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|感情問題多，生活較沒有目標。|;
		  }

# ＊ 大小限遇貪狼星主桃花運，社交應酬運旺。
# ＊ 貪狼武曲同宮，先貧而後富。（利己損人。命有紫微日月左右昌曲拱照，限逢祿權科，則貴顯論）
# ＊ 貪狼四生四墓宮，破軍忌煞百工通。
# ＊ 貪狼火鈴于四墓宮，豪富家資侯伯貴。（辰戌宮佳，丑未宮次之，若守照俱可論吉。加羊陀空劫不合此格）
# ＊ 貪武同行，威壓邊夷。（貪武遇大旺地是也）


# 貪狼的旺度為陷，形小而聲高，性情不常；而量大，好施小惠於人。有錯誤時，人們每在初時恨之入骨，終則諒之。作事性急，好弄巧，有嗜好，酒色煙賭無所不好，無所不能。

		  if($you->{ziwei}->{"貪狼"}->{bright} eq "陷" ){
		       push @{$res->{$k}->{"additional"} },qq|形小而聲高，性情不常；而量大，好施小惠於人。有錯誤時，人們每在初時恨之入骨，終則諒之。作事性急，好弄巧，有嗜好，酒色煙賭無所不好，無所不能。|;
		   }


# 命宮的宮位為「申」，能流芳百世，亦能遺臭萬年，為一部分人所指責反對，而又為另一部分人所欽敬崇拜；一生事業由堅苦奮鬥中得來，若享受淫樂，則事業又將在安樂中失去。
		  if($self->born(  time=>["申"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|能流芳百世，亦能遺臭萬年，為一部分人所指責反對，而又為另一部分人所欽敬崇拜；一生事業由堅苦奮鬥中得來，若享受淫樂，則事業又將在安樂中失去。|;
		  }
# 命宮的宮位為「寅」，且命宮有：六煞，主人聰明，少年顯揚，但事業雖能創立，而牢獄災禍與事業並來。
		  if($self->born(  time=>["寅"] ) &&  $self->has_sixghost() ){

			    push @{$res->{$k}->{"additional"} },qq|主人聰明，少年顯揚，但事業雖能創立，而牢獄災禍與事業並來。|;

		  }

# 命宮的宮位為「巳」，主圓滑活動，但一生災遇極多，但都能脫危而安。
		  if($self->born(  time=>["巳"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|主圓滑活動，但一生災遇極多，但都能脫危而安。|;
		  }

# 身宮有：七殺，有偷花淫奔的作風。
		  if($self->has_stars(  stars=>["七殺"] )){
		      push @{$res->{$k}->{"additional"} },qq|有偷花淫奔的作風。|;
		  }

# 身宮有：破軍，狂醉豪賭，視色如命。主浮蕩，不安家室，好交友，有嗜好。
		  if($self->has_stars(  stars=>["破軍"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|狂醉豪賭，視色如命。主浮蕩，不安家室，好交友，有嗜好。|;
		  }
		
# 命宮有：文昌、文曲、天虛、陰殺，作事虛而不實，善巧騙。
		  if($self->has_stars(  stars=>["文昌","文曲","天虛","陰煞"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|作事虛而不實，善巧騙。|;
		  }
		
# 命宮四正無六煞，為軍警或政界中人士。
# 命宮四正無六煞，事業極大，左右經濟形勢，掌握財政大權。否則，須在商界謀發展。
		  #四正
		 my @sz = ($self->{pos} , $self->{pos}+4, $self->{pos}+6  , $self->{pos}+8);
		  my $szs =0;
		foreach (@sz) {
			if( !$self->has_sixghost() ){
				  $szs++;

			}

		}
		if($szs ){
		      push @{$res->{$k}->{"additional"} },qq|為軍警或政界中人士。事業極大，左右經濟形勢，掌握財政大權。否則，須在商界謀發展。|;

		}

# 命宮無六煞，由白手成大業。牢獄災禍，一生東西逃，嘗盡甜酸苦辣。

			if( !$self->has_sixghost() ){
			      push @{$res->{$k}->{"additional"} },qq|由白手成大業。牢獄災禍，一生東西逃，嘗盡甜酸苦辣。|;


			}
# 命宮的宮位為「午」，善計謀，雄才略。

		  if($self->born(  time=>["午"] )   ){
		      push @{$res->{$k}->{"additional"} },qq|善計謀，雄才略。|;
		  }


# 女命多有嗜好宗教信仰，有丈夫志，性情剛毅，重毛髮，旺夫益子。

		  if( $you->{sex} eq 1  ){
		      push @{$res->{$k}->{"additional"} },qq|多有嗜好宗教信仰，有丈夫志，性情剛毅，重毛髮，旺夫益子。|;

		  }


	      }

		################   巨門   ####################  
		if($k eq "巨門"){
		  $res->{$k}->{"main"}.= qq|
 容貌：似不友善、難於親近。

性格：做事進退、多學少精。處事仔細、寡合是非。

人格類型：支援型 (口語溝通力)。

個性特質：糾紛、深思、懷疑、能辯、堅持 、猜忌、口舌、食祿、紛擾、易有官非、細心、善於分析。能有效地面對面溝通及在團體中的溝通。

愛情：耿直好辯。

優點：心思細密，耿直明快，專心一意，理解力強，中規中矩，直來直往。
缺點：恃才傲物，多疑善辯，刀子嘴、豆腐心；難得助力，不易服人。
   化氣為暗、主口舌是非、明爭暗鬥，為變化性最大的一顆星，有〝波折〞之意。管是非、虛偽、暗瞞、多疑、陰刑。性惡則口舌是非，善則敦厚溫良，能言善辯，擅於處理公共關係。有專門技能，研究心很仔細，多勞多能，但多學少精，行事略帶情緒化稍嫌偏激。不太合群，斷章取義，小題大作或多管閒事，喜與人爭，易犯小人，有點神祕感，且性多疑善欺瞞，猜忌。口才犀利，人緣一般都不大好。因口舌是非較多，於人身命較多猜疑、猶豫。巨門又為口才，化祿化權可靠口才謀生。不宜早婚。亦表辛勞，皆為幼年坎坷，必須辛勤奮鬥後才能有所收獲。要存錢大多得要借外力的幫助才會成功。巨門算是疑心病最重的，是個謹慎的消費者。口才一向很好的巨門星，可說是甜言蜜語的高手，但有時總是會想的太多、鑽牛角尖，所以較易去接觸宗教等心靈層次的東西。

		    性格耿直，口直心快，想到便說。所以往往無心中得罪了人，而自己毫不知情。
		    身態：目光銳利，善於察言觀色，反應佳。長方面或長圓面。
		    命宮有：太陽，主面色紅白或紅黃。否則，主人面色青黃。
		    個性：性質忠厚，面目清秀，有專門技能，善口才，能急辯。有正義感，無事奔忙，多學少精，能學法律、機械、醫學及星相雜藝；或是大眾師表，幫會領袖。為人忠厚，有點傲氣，不滿現實，因自己看得比一般人深入之故。

		      		|;

		  ########special
		  if( $self->has_jiagong (  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
		   if($you->{ziwei}->{"巨門"}->{bright} eq "陷"){
		    push @{$res->{$k}->{"additional"} },qq|做事進退失據，遲疑不決|;

		    }

# ＊ 巨門廟旺，雖富貴亦不耐久。
		   if($you->{ziwei}->{"巨門"}->{bright} eq "廟" || $you->{ziwei}->{"巨門"}->{bright} eq "旺"){
		    push @{$res->{$k}->{"additional"} },qq|雖富貴亦不耐久。|;

		    }

# ＊ 巨門守命身宮，一生招口舌是非。
		    push @{$res->{$k}->{"additional"} },qq|一生招口舌是非。|;
# ＊ 巨門子午科權祿，石中隱玉福興隆。（為石中隱玉格，富而且貴，辛癸生人上格。丁己生人次之，丙戊生人主困）

		  if($self->born(  time=>["子","午"] ) &&  $self->has_huaji( star=>$k, stars=>[ "科","權","祿"]  ) ){
		      push @{$res->{$k}->{"additional"} },qq|石中隱玉福興隆。（為石中隱玉格，富而且貴，辛癸生人上格。丁己生人次之，丙戊生人主困）|;
		  }

# ＊ 巨門辰戌不得地，辛人命遇反為奇。
		  if($self->born(  time=>["辰","戌"] )   && ( $you->{ziwei}->{"巨門"}->{bright} eq "不"  ||  $you->{ziwei}->{"巨門"}->{bright} eq "得" )){
		      push @{$res->{$k}->{"additional"} },qq|不得地，辛人命遇反為奇。餘皆不吉|;
		  }
# ＊ 辰戌應嫌陷巨門。（辛生人命遇反為奇格。 餘皆不吉）
		  if($self->born(  time=>["辰","戌"] )   && ( $you->{ziwei}->{"巨門"}->{bright} eq "陷"  )){
		      push @{$res->{$k}->{"additional"} },qq|不得地，辛人命遇反為奇。餘皆不吉|;
		  }
# ＊ 巨門丑未陷地，為下格。
		  if($self->born(  time=>["丑","未"] )   &&  $you->{ziwei}->{"巨門"}->{bright} eq "陷"){
		      push @{$res->{$k}->{"additional"} },qq|為下格。|;
		  }

# ＊ 巨機居卯，公卿之位。（巨機二星在卯同宮吉，在酉同宮則不美。為巨機同臨格）
		  if($self->born(  time=>["卯"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|公卿之位。|;
		  }

		  if($self->born(  time=>["酉"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|則不美。|;
		  }

# ＊ 巨機居卯，乙辛丙生人，位至公卿。（不貴即富。但甲生人平常，因甲祿在寅，卯宮有擎羊破格也）
		  if($self->born(  time=>["卯"] )  && $self->born(  time=>["乙","辛","丙"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|位至公卿。 |;
		  }
		  if($self->born(  time=>["甲"] )  && $self->born(  time=>["寅"] ) && $self->has_stars(  stars=>["祿存"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|平常。 |;
		  }  
		  if($self->has_stars( pos=>$self->position(time=>["卯"]), stars=>["擎羊"]) ){
		      push @{$res->{$k}->{"additional"} },qq|破格也。 |;
		  }

# ＊ 巨機酉上化吉者，縱有財官也不終。（如值，孤貧多有壽，巨富即夭亡，加化忌尤凶）
		  if($self->born(  time=>["酉"] ) &&  $self->has_huaji( star=>$k, stars=>[ "科","權","祿"]  )  ){
		      push @{$res->{$k}->{"additional"} },qq|縱有財官也不終。（如值，孤貧多有壽，巨富即夭亡，加化忌尤凶）|;
		  }

# ＊ 女命，巨門天機為破蕩。（女命巨機同宮於卯酉，雖富貴不免淫佚）
		  if( $you->{sex} eq 1 ){
		      if( $self->has_stars(  stars=>["天機"] ) ){
			      push @{$res->{$k}->{"additional"} },qq|破蕩。 |;
			}    
		    if($self->born(  time=>["卯","酉"] )   ){
		      push @{$res->{$k}->{"additional"} },qq|雖富貴不免淫佚。 |;
			}
		   }
# ＊ 巨日同宮，官封三代。（寅宮安命，無劫空四煞上格。申宮次之）
	    if( $self->has_stars(  stars=>["太陽"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|官封三代。（寅宮安命，無劫空四煞上格。申宮次之）
		    |;
	      }   

# ＊ 巨日寅宮守命，食祿馳名。（為巨日同宮格）
	    if( $self->has_stars(  stars=>["太陽"] ) && $self->born(  time=>["寅"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|食祿馳名。
		    |;
	      }   
# ＊ 巨日申宮守命，亦妙。
	    if( $self->has_stars(  stars=>["太陽"] ) && $self->born(  time=>["申"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|亦妙。
		    |;
	      }   
# ＊ 巨日寅宮，命立申，食祿馳名。
# ＊ 巨日申宮，命立寅，食祿馳名。
	    if( $self->has_stars(  stars=>["太陽"] ) && $self->born(  time=>["寅"] )&& $self->born(  time=>["申"] ) ){
		    push @{$res->{$k}->{"additional"} },qq|食祿馳名。
		    |;
	      } 

# ＊ 巨在亥宮，日命巳，食祿馳名。
	    if( $self->born(  time=>["亥"] ) && $self->has_stars( pos=>$self->position(time=>["巳"]), stars=>["太陽"])  ){
		    push @{$res->{$k}->{"additional"} },qq|食祿馳名。
		    |;
	      } 
# ＊ 巨日巳宮，日命亥，反為不美。
	    if( ($self->born(  time=>["巳"] ) && $self->has_stars(  stars=>["太陽"] ) ) || ($self->has_stars( pos=>$self->position(time=>["巳"]), stars=>["太陽"]))  ){
		    push @{$res->{$k}->{"additional"} },qq|反為不美。
		    |;
	      } 

# ＊ 巨日拱照亦為奇。（假如日午宮，巨在戌宮是也，吉多方論，日忌陷）
		       if($self->has_shanhe(  stars=>["太陽"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|亦為奇 亦為奇|;
			}

# ＊ 巨門四煞陷而凶。
		       if($self->has_fourghost() && $you->{ziwei}->{"巨門"}->{bright} eq "陷"  ){
			      push @{$res->{$k}->{"additional"} },qq|凶。|;
			}
# ＊ 巨門羊陀於身命、疾厄，羸黃困弱。
		       if($self->has_stars(  stars=>["擎羊","陀羅"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|羸黃困弱。|;
			}
# ＊ 巨門守命，見羊陀，男女邪淫。
		       if($self->has_jiahui(  stars=>["擎羊","陀羅"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|男女邪淫。|;
			}
# ＊ 巨門陀羅，必生異痣。
		       if($self->has_stars(  stars=>["陀羅"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|必生異痣。|;
			}
# ＊ 巨門陀羅同居身命、疾厄宮，主貧困、體弱、殘疾、祖業漂蕩、奔波勞碌。
		       if($self->has_stars(  stars=>["陀羅"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|主貧困、體弱、殘疾、祖業漂蕩、奔波勞碌。|;
			}
# ＊ 巨火擎羊，終身縊死。（此三星坐守身命，大小二限又逢惡煞，主終身縊死）
		       if($self->has_stars(  stars=>["擎羊","火星"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|終身縊死。（此三星坐守身命，大小二限又逢惡煞，主終身縊死）|;
			}


# ＊ 巨門火鈴，無紫微祿存壓制，決配千里，遭凶。
		       if($self->has_stars(  stars=>["鈴星","火星"] ) &&  ! $self->has_stars(  stars=>["紫微","祿存"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|決配千里，遭凶。|;
			}
# ＊ 巨門守命，三合煞湊，必遭火厄。
		       if($self->has_shanhe(  stars=>@sixghosts )  ){
			      push @{$res->{$k}->{"additional"} },qq|必遭火厄。|;
			}
# ＊ 巨門守命，見太陽，吉凶參半。
		       if($self->has_jiahui(  stars=>["太陽"]  )  ){
			      push @{$res->{$k}->{"additional"} },qq|吉凶參半。|;
			}


# ＊ 巨門代表是非。
			      push @{$res->{$k}->{"additional"} },qq|代表是非。|;
			
# ＊ 巨門北斗星，是非星，六親緣薄；與人交往開始熱絡以不歡而散結束，十二宮中到處為災，奔波勞碌。
			      push @{$res->{$k}->{"additional"} },qq|北斗星，是非星，六親緣薄；與人交往開始熱絡以不歡而散結束，十二宮中到處為災，奔波勞碌。|;
# ＊ 巨門做事負責認真，合情合理也易受人口舌不滿。
			      push @{$res->{$k}->{"additional"} },qq|做事負責認真，合情合理也易受人口舌不滿。|;
# ＊ 巨門化祿：業績佳，善於買賣，能言善道。
		  if($you->{ziwei}->{"巨門"}->{bright} eq "祿"){
		      push @{$res->{$k}->{"additional"} },qq|業績佳，善於買賣，能言善道。|;
		  }
# ＊ 巨門化權：管理能力佳，能言善道，唯小心中傷人，反犯小人。
		  if($you->{ziwei}->{"巨門"}->{bright} eq "權"){
		      push @{$res->{$k}->{"additional"} },qq|管理能力佳，能言善道，唯小心中傷人，反犯小人。|;
		  }
# ＊ 巨門化忌：叛逆心重，口舌是非，莫名之災，事業變動。
		  if($you->{ziwei}->{"巨門"}->{bright} eq "忌"){
		      push @{$res->{$k}->{"additional"} },qq|叛逆心重，口舌是非，莫名之災，事業變動。|;
		  }
# ＊ 巨門加會左輔、右弼，衣食無缺，有貴人助。
		  if($self->has_jiahui(  stars=>["左輔","右弼"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|衣食無缺，有貴人助。|;
		  }
# ＊ 巨門加會文昌、文曲，有文采，說話有道理，反應靈活，宜公職，文化事業，感情不定。 
		  if($self->has_jiahui(  stars=>["文昌","文曲"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|有文采，說話有道理，反應靈活，宜公職，文化事業，感情不定。 |;
		  }
# ＊ 巨門加會天魁、天鉞，宜公職，文化事業，有貴人相助。
		  if($self->has_jiahui(  stars=>["天魁","天鉞"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|宜公職，文化事業，有貴人相助。|;
		  }
# ＊ 巨門加會科、權、祿，有實力，事業有成。
		    if($self->has_jiahui_huaji( star=>$k, stars=>["祿","權","祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|有實力，事業有成。|;
		    }	  
# ＊ 巨門加會火星或鈴星易得罪人，小心火災。
		  if($self->has_jiahui(  stars=>["火星"]  ) || $self->has_jiahui(  stars=>[ "鈴星"]) ){
			push @{$res->{$k}->{"additional"} },qq|易得罪人，小心火災。|;
		  }
# ＊ 巨門加會擎羊、陀羅：感情或人事是非不斷，易受傷。
		  if($self->has_jiahui(  stars=>["擎羊","陀羅"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|感情或人事是非不斷，易受傷。|;
		  }
# ＊ 巨門加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌，口舌感情問題多，壓力重。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|口舌感情問題多，壓力重。|;
		  }
# ＊ 大小限遇巨門星主容易出名。
# 
# ＊ 子羽才能，巨宿同梁沖且合。（申安命，天同子宮，巨門寅宮，天梁辰宮，又得科權祿左右拱沖）
# ＊ 巨門羊陀於身命、疾厄，羸黃困弱。
# ＊ 巨門陀羅同居身命、疾厄宮，主貧困、體弱、殘疾、祖業漂蕩、奔波勞碌。
# ＊ 巨門在兄弟宮，骨肉參商。
# ＊ 巨門在夫妻宮，主生離死別，縱夫妻有對，不免汙名失節。
# ＊ 巨門在子女宮，損後方招，雖有而無。
# ＊ 巨門在財帛宮，有競爭。
# ＊ 巨門在疾厄宮，遇羊陀，眼目之疾，煞臨，主殘疾。
# ＊ 巨門在遷移宮，招是非。
# ＊ 巨門在僕役宮，多怨逆。
# ＊ 巨門在官祿宮，主招刑杖。
# ＊ 巨門在田宅宮，破蕩祖業。
# ＊ 巨門在祿德宮，勞心不安。
# ＊ 巨門在父母宮，遭棄擲。
# ＊ 巨門火鈴，逢惡限，死於外道。（為巨逢四煞格）

# 巨門的旺度為廟，或太陽的宮位為「巳」，或太陽的宮位為「午」，主肥胖，中高身材，否則主中等身材，或瘦小。

		  if($you->{ziwei}->{"巨門"}->{bright} eq "廟" || $self->born(  time=>["巳","午"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|主肥胖，中高身材，否則主中等身材，或瘦小。|;
		  }
		 
# 巨門的旺度為陷，或命宮有化忌，容易口舌厭人，多事多非。
		  if($you->{ziwei}->{"巨門"}->{bright} eq "陷" ||  $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		      push @{$res->{$k}->{"additional"} },qq|容易口舌厭人，多事多非。|;
		  }

# 命宮有：化權、化祿、祿存，能富能貴。

		    if( $self->has_huaji( star=>$k, stars=>[ "權","祿"] )||$self->has_stars(  stars=>["祿存"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|能富能貴。|;
		    }
# 命宮有：化忌，口舌連連，災禍紛紛。凡事多疑少決，舉棋不定。

		  if($self->has_huaji( star=>$k, stars=>[ "忌"] )){
		      push @{$res->{$k}->{"additional"} },qq|口舌連連，災禍紛紛。凡事多疑少決，舉棋不定。|;
		  }

# 命宮有：陀羅，身有異痣。

		  if($self->has_stars(  stars=>["陀羅"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|身有異痣。|;
		  }
# 命宮有：擎羊、陀羅、火星、鈴星、劫殺、天刑、陰殺，且命宮無祿存、化祿、化權，主有投河服毒、輕生自盡等情事發生。或遭火災，或被配發前線，或則奔波千里，作事顛倒，主張全無。

		  if($self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星","劫殺","天刑","陰煞"] ) && (!$self->has_stars(  stars=>["祿存"] )  && !$self->has_huaji( star=>$k, stars=>[ "祿","權"] )) ){


			  push @{$res->{$k}->{"additional"} },qq|    主有投河服毒、輕生自盡等情事發生。或遭火災，或被配發前線，或則奔波千里，作事顛倒，主張全無。|;
		  }

# 女命巨門的旺度為廟，且命宮有：化權、化祿、祿存，主富主貴，而且壽命極長。

		 
		  if( $you->{sex} eq 1  ){
			  if($you->{ziwei}->{"巨門"}->{bright} eq "廟" ){

			    if($self->has_stars(  stars=>["祿存"] )  || $self->has_huaji( star=>$k, stars=>[ "祿","權"] )  ){
			    push @{$res->{$k}->{"additional"} },qq|      主富主貴，而且壽命極長。|;
			  }
		  }
# 命宮有：擎羊、陀羅、火星、鈴星、天刑，主刑剋壽夭，以繼室偏房為宜，但仍多爭多鬥。
			  if($self->has_stars(  stars=>["擎羊","陀羅","火星","鈴星","天刑"] ) ) {
				  push @{$res->{$k}->{"additional"} },qq|	    主刑剋壽夭，以繼室偏房為宜，但仍多爭多鬥。
				  |;
				}



		  }



	      }

		################   天相   ####################  
		if($k eq "天相"){
		  $res->{$k}->{"main"}.= qq|

 容貌：相貌敦厚、持重清白。

性格：持重清白、愛好衣食。服務心重、犧牲心重。

人格類型：領導型 (派任能力)。

個性特質：忠誠正直、品味、享受、好打抱不平 、印信、擔保。能快速對任務下決策及分配職掌。

愛情：豔冠群芳。

優點：斯文有禮，應對得體，謹慎踏實，思慮週全，溝通力強，人際和諧。
缺點：意志不堅，粉飾太平，眼高手低，多說少做，輕言允諾，虛榮心重。

  相貌端正、謹言慎行、負責、忠厚老實、誠信有正義感、性溫和、樂助人、服務熱心，優雅樂觀，喜調解紛爭與平衡心態，故給人穩定的感覺，相當忠貞善良，所以人際關係良好。唯衝勁不足，故好管閒事又怕事，方正而不夠圓融，容易遠離層峰核心。於人身命，主人心性豪爽，顯象貴氣，愛好和平，有惻隱之心，喜歡名譽與聲望。能處處犧牲小我而替人著想，總是寬厚體貼，對他人總是發揮人飢己飢、人溺己溺的精神，不僅毫不猶豫的幫助他人，更有一顆寬厚誠懇的心，嚴以律己，寬以待人，喜歡凡事都照著自己的計畫流程來，是理想的幕僚人才。有種外放的能力，是消費能力很高的族群，是求精不求量的人，要買就是要買好的，也是很重視另一伴的外表、打扮、裝飾等。天相十分受外在環境而變化，最怕火鈴。


				      衣祿豐盈。
		有正義感，略帶桃花，樂易幫助別人。做事堅持自己的原則，有責任心，並有為人排解困難的天賦潛能。
		身態：主人面色清白或略帶黃色。方面型或略帶微圓。中等身材，亦有肥胖者。
		個性：性情寬厚，相貌敦厚有精神，言語誠實不虛偽。若論毛病，說話較注重場面，內容莊重，有板有眼，但並非本身完全能到的。態度大方，舉動穩重，有正義感，路見不平，能拔刀相助。信仰宗教，喜修行，感情容易衝動。對於任何人困難或不良的遭遇，便會生同情心。		      		

	      |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
# ＊ 落陷奸詐沉浮。
		  if($you->{ziwei}->{"天相"}->{bright} eq "陷" ){
			   push @{$res->{$k}->{"additional"} },qq|奸詐沉浮。|;
		  }

# ＊ 天相守命，左右昌曲相會，位至公卿。
		  if( $self->has_jiahui(  stars=>["文昌","文曲","左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|位至公卿。|;
		  }

# ＊ 天相守命，若居閑陷之地，也作吉利。
		  if($you->{ziwei}->{"天相"}->{bright} eq "閑" || $you->{ziwei}->{"天相"}->{bright} eq "陷"){
			   push @{$res->{$k}->{"additional"} },qq|也作吉利。|;
		  }
# ＊ 天相陷地，貪廉武破羊陀煞湊，巧藝安身。
		  if($you->{ziwei}->{"天相"}->{bright} eq "陷" && $self->has_jiahui(  stars=>["貪狼","廉貞","武曲","破軍","擎羊","陀羅"])){
			   push @{$res->{$k}->{"additional"} },qq|巧藝安身。|;
		  }
# ＊ 天相守命，遇火鈴衝破，殘疾。
		  if($self->has_jiahui(  stars=>["鈴星","火星"])){
			   push @{$res->{$k}->{"additional"} },qq|殘疾。|;
		  }
# ＊ 天相守命，廉貞擎羊夾，刑杖難逃。終身不美，遭橫禍，只宜僧道（按天相不可能被貞羊所夾，恐是同宮或會合）
		  if($self->has_shanhe(  stars=>["廉貞","擎羊"]) || $self->has_jiagong(  stars=>["廉貞","擎羊"])){
			   push @{$res->{$k}->{"additional"} },qq|刑杖難逃。終身不美，遭橫禍，只宜僧道（按天相不可能被貞羊所夾，恐是同宮或會合）|;
		  }
# ＊ 天相之星女命纏，必當子貴與夫賢。（女命己生人子宮，甲生人午宮，庚生人午宮，俱是貴格）
		  if( $you->{sex} eq 1  ){
			   push @{$res->{$k}->{"additional"} },qq|必當子貴與夫賢。|;
			if( ($self->born(  time=>["巳"] ) &&  $self->born(  time=>["子"] ) ) || ($self->born(  time=>["甲"] ) &&  $self->born(  time=>["午"] ) ) || ($self->born(  time=>["庚"] ) &&  $self->born(  time=>["午"] ) )){
			    push @{$res->{$k}->{"additional"} },qq|      俱是貴格。|;
			}
# ＊ 女命，天相右弼福來臨。
#      （女命天相左右諸宮吉，癸生人子宮，癸己生人寅宮，甲庚癸生人申宮，俱是貴格。丑未亥宮不貴。子午卯酉皆少福）
		  if($self->has_shanhe(  stars=>["右弼"]) ){
			   push @{$res->{$k}->{"additional"} },qq|福來臨。|;

			if( ($self->born(  time=>["癸"] ) &&  $self->born(  time=>["子"] ) ) || ($self->born(  time=>["癸"] ) &&  $self->born(  time=>["寅"] ) ) || ($self->born(  time=>["甲"] ) &&  $self->born(  time=>["癸"] ) )){
			    push @{$res->{$k}->{"additional"} },qq|      俱是貴格。|;
			}
			if( ($self->born(  time=>["丑","未","亥"] ) ) ){
			    push @{$res->{$k}->{"additional"} },qq|      不貴。|;
			}
			if( ($self->born(  time=>["子","午","酉"] ) ) ){
			    push @{$res->{$k}->{"additional"} },qq|      皆少福。|;
			}
		  }		      
			

		  }
# ＊ 天相代表文書，衣食。
			    push @{$res->{$k}->{"additional"} },qq|      文書，衣食。|;
# ＊ 天相說話莊重得體，喜在上流社會交際。
			    push @{$res->{$k}->{"additional"} },qq|      莊重得體，喜在上流社會交際。|;

# ＊ 天相加會左輔、右弼，有權位，衣食無缺，生活安樂，有友人助。
		  if($self->has_jiahui(  stars=>["左輔","右弼"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|有權位，衣食無缺，生活安樂，有友人助。|;
		  }

# ＊ 天相加會文昌、文曲，有文采，說話有道理，彬彬有禮。
		  if($self->has_jiahui(  stars=>["文昌","文曲"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|有文采，說話有道理，彬彬有禮。|;
		  }

# ＊ 天相加會天魁、天鉞，結交有地位人士，有貴人相助。
		  if($self->has_jiahui(  stars=>["天魁","天鉞"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|結交有地位人士，有貴人相助。|;
		  }
# ＊ 天相加會科、權、祿，有實力有作為，事業有成。
		    if($self->has_jiahui_huaji( star=>$k, stars=>["祿","權","祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|有實力有作為，事業有成。|;
		    }	
# ＊ 天相加會火星或鈴星小心災傷。
		  if($self->has_jiahui(  stars=>["火星"]  ) || $self->has_jiahui(  stars=>[ "鈴星"])  ){
			push @{$res->{$k}->{"additional"} },qq|小心災傷。|;
		  }
# ＊ 天相加會擎羊、陀羅感情多風波，破財。
		  if($self->has_jiahui(  stars=>["擎羊","陀羅"]  )  ){
			push @{$res->{$k}->{"additional"} },qq|感情多風波，破財。|;
		  }
# ＊ 天相加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌，變動大，煩憂多，宜技藝安身。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|變動大，煩憂多，宜技藝安身。|;
		  }

# ＊ 天相守命，若臨生旺之鄉，雖不逢紫微，若得左右，則職掌權威。
# ＊ 大小限遇天相星主社交多。
# ＊ 天相南斗星，是事業宮主，居事業宮為得位。


# 命宮有：左輔、右弼、天魁、天鉞、三台、八座、天貴、恩光、天德、解神、天巫，且命宮有：化祿、化權、化科、祿存、天馬，主人位居極品，出將入相，國家砥柱，社會領袖，既貴且富。

		  if($self->has_stars(  stars=>["左輔","右弼","天魁","天鉞","三台","八座","天貴","恩光","天德","解神","天巫"] ) && ( $self->has_huaji( star=>$k, stars=>[ "祿","權","科"] ) || $self->has_stars(  stars=>["祿存","天馬"] )  ) ){

			  push @{$res->{$k}->{"additional"} },qq|    主人位居極品，出將入相，國家砥柱，社會領袖，既貴且富。|;

		  }

# 命宮有：紫微星、祿存，為人有偏見，或主見極深，好爭權，同時也容易遭到小人的傾擠。
		  if($self->has_stars(  stars=>["紫微","祿存"] )){
			  push @{$res->{$k}->{"additional"} },qq|    為人有偏見，或主見極深，好爭權，同時也容易遭到小人的傾擠。|;
			}

# 命宮有：武曲、廉貞、貪狼、天才、鳳閣，為人聰明好學，多才多藝。
		   
		  if($self->has_stars(  stars=>["武曲","廉貞","貪狼","天才","鳳閣"] )){
			  push @{$res->{$k}->{"additional"} },qq|    為人聰明好學，多才多藝。|;
			}

		   
# 命宮有：擎羊、陀羅且天相的旺度為陷，主人以技術或藝術養生。
		  if($self->has_stars(  stars=>["擎羊","陀羅"] ) && $you->{ziwei}->{"天相"}->{bright} eq "陷" ){
			  push @{$res->{$k}->{"additional"} },qq|    主人以技術或藝術養生。|;
			}
# 命宮有：祿存、化權、化科，以事門技能或藝術起家。

		  if($self->has_stars(  stars=>["祿存"] ) || $self->has_huaji( star=>$k, stars=>[ "科","權"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    以事門技能或藝術起家。|;
			}

# 命宮有：火星、鈴星、天刑、天月、陰煞、天空、地劫、大耗，主刑剋，或身殘疾。
		   
		  if($self->has_stars(  stars=>["火星","鈴星","天刑","天月","陰煞","天空","地劫","大耗"] )){
			  push @{$res->{$k}->{"additional"} },qq|    主刑剋，或身殘疾。|;
			}

# 命宮有：武曲、破軍、文昌、文曲、左輔、右弼、陀羅、天馬、化祿，主人時成時敗、忽起忽落。成功則增田置產不可一世，失敗刖牢獄災禍，小人包圍，刑剋傷害。此吉中藏凶，而凶中藏吉的忽善忽惡變化。
		   
		  if($self->has_stars(  stars=>["武曲","破軍","文昌","文曲","左輔","右弼","陀羅","天馬"] )  || $self->has_huaji( star=>$k, stars=>[ "祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    主人時成時敗、忽起忽落。成功則增田置產不可一世，失敗刖牢獄災禍，小人包圍，刑剋傷害。此吉中藏凶，而凶中藏吉的忽善忽惡變化。|;
			}


# 女命好打扮自己，貪吃、挑食，有笑容。主人聰明持重，有丈夫志氣。
		 
		  if( $you->{sex} eq 1  ){
		      push @{$res->{$k}->{"additional"} },qq|女命好打扮自己，貪吃、挑食，有笑容。主人聰明持重，有丈夫志氣。
|;

# 命宮有：化祿、化權、化科、祿存、左輔、右弼、天馬，乃夫人之命，旺夫教子，富貴雙全。
		      if($self->has_stars(  stars=>["祿存","左輔","右弼","天馬"] ) || $self->has_huaji( star=>$k, stars=>[ "祿","權","科"] )  ){
			      push @{$res->{$k}->{"additional"} },qq|	乃夫人之命，旺夫教子，富貴雙全。|;
			    }

# 命宮有：文昌、文曲、化忌、擎羊，主孤獨，以出家修行，或以繼室偏房及不舉行結婚儀式之同居為宜，否則刑剋分離。
		  if($self->has_stars(  stars=>["文昌","文曲","擎羊"] ) || $self->has_huaji( star=>$k, stars=>[ "忌"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    主孤獨，以出家修行，或以繼室偏房及不舉行結婚儀式之同居為宜，否則刑剋分離。|;
			}

		   }

		  


	      }

		################   天梁   ####################  
		if($k eq "天梁"){
		  $res->{$k}->{"main"}.= qq|

 容貌：穩穩厚重、老成端莊。

性格：心無私曲、愛好濟施。有統帥力、稍嫌專制。

人格類型：合作型 (意志力)。

個性特質：良心、關懷、耿直、自律、穩重 、長壽、逢凶化吉、清高、專制、不受約束、醫藥、權謀。能在一個職位或工作上久留，直到目標被完成或不再獲得事物。

愛情：堅毅強韌。

優點：慈悲為懷，成熟穩重，思想超然，客觀公正，具有俠義精神，能夠臨危授命，施恩不求報償，重視公益服務。
缺點：老氣橫秋，太重面子，感情用事，喜受奉承，過度熱心，難得安閒，吃虧上當，操心煩神。

		       主壽、貴，是父母之星、蔭星、老大之星，主清高、慷慨、化吉之星，故雖遭災難不免多憂慮，但有逢凶化吉功能，尤其當災碰上身時，更能增強生命力。為人喜照顧別人、有正義感，會路見不平、心善霸道固執、孤高自負有威嚴，喜自由自在的生活。天梁為"清官"，與五術緣深。任勞任怨。福壽延年。宗教色彩濃厚。遇難成祥，但是強求之事不易達成，反而無得失心，收穫更大。於人命身時，喜歡充老大，愛管閒事，喜領導統御，顯象早熟。厚重謙恭，頗具長輩緣，對部屬及晚輩亦心存關愛，臨事有決斷之能力，有文學藝術之細胞，出外喜爭面子，但難免帶點傲氣。對婚姻則不善表達其人之感情。不重財，即使碰到財帛宮化祿也幾乎沒有助力。天梁可是囉唆型的消費者，當然對老字號有口碑的較有信心。很容易為純樸的異性所著迷，但是這不代表他們胸無大志哦，他們只是較喜歡清閒的生活罷了，另外天梁星也有沒事愛找另一半鬥嘴的習慣。此外，必先有災才可發揮天梁的本性，雖然最後凶終能散，但人生幅度變化太大，亦非佳造。天梁不甚喜化祿，但喜化科，最能表現天梁良好一面，更得輔弼曲昌同會，更能發揮天梁"蔭"的本質，危機過後反而更加精彩。

		  壽星之主，秉性耿直。
		    偏重精神而不偏重物質，原則性強。福星，常有下列機會：得祖上遺產。代理名牌產品。享受他人現成事業。繼承某種現成事務。不利經商。
		    身態：形貌厚重清秀，行事大方，看起來很成熟、閱歷豐富的樣子。主人面色黃白。長方面型，鼻直顴高，身體胖瘦不一，惟以微胖者多。身軀中矮，亦有瘦長者。
		    個性：心直無曲、膽大心大，有分析能力，喜出風頭，一副龍頭老大德性。態度穩重大方，性情耿直。一生雖有災過，但主壽長。見凶能化，逢災能解。		      		

		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 命宮或對宮有天梁，主有壽。

		  if($self->has_stars(  stars=>["天梁"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    主有壽。|;
			

		   }
# ＊ 梁居午位，官資清顯。（為壽星入廟格。丁己癸人合格）
		  if($self->born(  time=>["午"] )   ){
		      push @{$res->{$k}->{"additional"} },qq|官資清顯。（為壽星入廟格。丁己癸人合格）|;
		  }

# ＊ 天梁廟旺，與天機同宮，工翰墨，善談兵。


		      if(($you->{ziwei}->{"天梁"}->{bright} eq "廟" || $you->{ziwei}->{"天梁"}->{bright} eq "旺" )&& $self->has_stars(  stars=>["天機"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    工翰墨，善談兵。|;
			}

		   
# ＊ 梁同機月寅申位，一生利業聰明。
		  if($self->has_stars(  stars=>["天同","天機","太陰"] ) && $self->born(  time=>["寅","申"] )   ){
		      push @{$res->{$k}->{"additional"} },qq|一生利業聰明。|;
		  }
# ＊ 天梁太陽昌祿會，臚傳第一名。
		  if($self->has_jiahui (  stars=>["太陽","文昌","祿存"] )    ){
		      push @{$res->{$k}->{"additional"} },qq|臚傳第一名。|;
		  }
# ＊ 天梁天同聚于命身宮，不怕凶危。
		  if($self->has_stars (  stars=>["天同"] )    ){
		      push @{$res->{$k}->{"additional"} },qq|不怕凶危。|;
		  }
# ＊ 梁同對居巳亥，男浪蕩，女多淫。（加羊陀煞湊，多下賤）
		  if($self->has_stars (  stars=>["天同"] )  && $self->born(  time=>["巳","亥"] )    ){
		      push @{$res->{$k}->{"additional"} },qq|男浪蕩，女多淫。|;
		       if($self->has_stars (  stars=>["擎羊","陀羅"] )    ){
		      push @{$res->{$k}->{"additional"} },qq|多下賤。|;
		      }
		      
		  }
# ＊ 梁酉、月巳，卻作飄篷之客。
	    if( $self->born(  time=>["酉"] )  || ($self->has_stars( pos=>$self->position(time=>["巳"]), stars=>["太陰"]))  ){
		    push @{$res->{$k}->{"additional"} },qq|卻作飄篷之客。
		    |;
	      } 
# ＊ 天梁文昌居廟旺，位至台綱。
		      if(($you->{ziwei}->{"天梁"}->{bright} eq "廟" || $you->{ziwei}->{"天梁"}->{bright} eq "旺" )&& $self->has_stars(  stars=>["文昌"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    位至台綱。|;
			}

		   
# ＊ 天梁廟旺，左右昌曲嘉會，出將入相。
		      if(($you->{ziwei}->{"天梁"}->{bright} eq "廟" || $you->{ziwei}->{"天梁"}->{bright} eq "旺" )&& $self->has_jiahui(  stars=>["文昌","文曲","左輔","右弼"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    出將入相。|;
			}

# ＊ 天梁天馬陷，飄蕩無疑。（巳亥申宮安命，天梁失陷，天馬同宮是也）
		      if($you->{ziwei}->{"天梁"}->{bright} eq "陷" && $self->has_stars(  stars=>["天馬"] ) && $self->born(  time=>["巳","亥","申"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    飄蕩無疑。|;
			}
			
# ＊ 天梁陷地，見羊陀，傷風敗俗之流。
		      if($you->{ziwei}->{"天梁"}->{bright} eq "陷" && $self->has_jiahui(  stars=>["擎羊","陀羅"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    傷風敗俗之流。 |;
			}
			
# ＊ 天梁陷地，遇火羊破局，下賤孤寡夭折。
		      if($you->{ziwei}->{"天梁"}->{bright} eq "陷" && $self->has_jiahui(  stars=>["擎羊","火星"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|   下賤孤寡夭折。|;
			}

# ＊ 天梁代表果決，機謀。
			  push @{$res->{$k}->{"additional"} },qq|   果決，機謀。|;
# ＊ 天梁南斗星，主人清秀溫和，形神穩重，性情磊落，善識兵法；為長壽星，解厄星，老大星，父母宮主星，居父母　宮為得位。
			  push @{$res->{$k}->{"additional"} },qq|   主人清秀溫和，形神穩重，性情磊落，善識兵法；為長壽星，解厄星，老大星|;
# ＊ 天梁愛照顧人為孤獨星，六親緣易薄。
			  push @{$res->{$k}->{"additional"} },qq|   愛照顧人為孤獨星，六親緣易薄。|;
# ＊ 天梁老大作風，喜高級生活，受人敬重。
			  push @{$res->{$k}->{"additional"} },qq|   老大作風，喜高級生活，受人敬重。|;
# ＊ 天梁加會左輔、右弼，生活經歷豐富，為善口碑佳；親朋好友相處融洽，事業有成，樂於助人。
		      if( $self->has_jiahui(  stars=>["左輔","右弼"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|   生活經歷豐富，為善口碑佳；親朋好友相處融洽，事業有成，樂於助人。|;
			}
			
# ＊ 天梁加會文昌、文曲，有文采學問，說話有道理，彬彬有禮，宜公職，文化事業，司法，監察。
		      if( $self->has_jiahui(  stars=>["文昌","文曲"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|   有文采學問，說話有道理，彬彬有禮，宜公職，文化事業，司法，監察。|;
			}
# ＊ 天梁加會天魁、天鉞，結交有地位人士，有貴人相助，宜公職，文化事業。
		      if( $self->has_jiahui(  stars=>["天魁","天鉞"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|   結交有地位人士，有貴人相助，宜公職，文化事業。|;
			}
			
# ＊ 天梁化祿：逢凶化吉，能言善道。 
		  if($self->has_huaji( star=>$k, stars=>[ "祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    逢凶化吉，能言善道。 |;
			

		   }

		   
# ＊ 天梁化權：管理能力佳，善使喚別人，能言善道，說話有道理。
		  if($self->has_huaji( star=>$k, stars=>[ "權"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    管理能力佳，善使喚別人，能言善道，說話有道理。|;
			

		   }
		   
# ＊ 天梁化科：學術研究，說話有道理，人緣佳。
		  if($self->has_huaji( star=>$k, stars=>[ "科"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    學術研究，說話有道理，人緣佳。|;
			

		   }
		   
		   
# ＊ 天梁加會科、權、祿，企業內部管理人才；天梁化祿會吹噓，易有糾紛，事業反不利。
		  if($self->has_jiahui_huaji( star=>$k, stars=>[ "科","權","祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    學術研究，說話有道理，人緣佳。|;
			

		   }
		   
		   
# ＊ 天梁加會火星或鈴星錢財不聚，義氣用事。
		      if( $self->has_jiahui(  stars=>["火星"] ) || $self->has_jiahui(  stars=>["鈴星"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|   錢財不聚，義氣用事。|;
			}
# ＊ 天梁加會擎羊、陀羅，好賭，刑傷。
		      if( $self->has_jiahui(  stars=>["擎羊","陀羅"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|   好賭，刑傷。|;
			}
			
# ＊ 天梁加會火星、鈴星、擎羊、陀羅，地空、地劫、化忌、不學無術或游手好閒者。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|不學無術或游手好閒者。|;
		  }

		  
# ＊ 天梁守照，吉相逢，平生福壽。（在午宮極佳）
# ＊ 大小限遇天梁星主昇遷運不主財。
# ＊ 命宮或對宮有天梁，主有壽。
# ＊ 天梁加吉坐遷移，鉅賈高賈。（加羊陀平常）
# ＊ 天梁、月曜，女淫貧。（梁巳亥，陰寅申，主淫貧。不陷衣祿遂，如陷下賤）
# ＊ 天梁南斗星，主人清秀溫和，形神穩重，性情磊落，善識兵法；為長壽星，解厄星，老大星，父母宮主星，居父母　宮為得位。


# 命宮的宮位為「巳」，每多負特殊使命或特殊職務者，或身兼數職，有公開者，有秘密者。
		  if($self->born(  time=>["巳"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|每多負特殊使命或特殊職務者，或身兼數職，有公開者，有秘密者。|;
		  }

# 命宮有：太陽、文昌、文曲，聰明出眾、但多心傲好勝。
		  if($self->has_stars(  stars=>["文昌","文曲","太陽"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|聰明出眾、但多心傲好勝。|;
		  }
# 命宮有：天機星，博古通今，善談好學，並識兵機。
		  if($self->has_stars(  stars=>["天機"] )   ){
		      push @{$res->{$k}->{"additional"} },qq|博古通今，善談好學，並識兵機。|;
		  }
# 命宮有：天空、地劫、大耗，主好遊蕩，無積儲，多破蕩。
		  if($self->has_stars(  stars=>["天空","地劫","大耗"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|主好遊蕩，無積儲，多破蕩。|;
		  }
# 命宮有：文昌、文曲、鳳閣，主文化界人士，或經營文化事業者，或新聞事業者。
		  if($self->has_stars(  stars=>["文昌","文曲","鳳閣"] )){
		      push @{$res->{$k}->{"additional"} },qq|主文化界人士，或經營文化事業者，或新聞事業者。|;
		  }
# 女命天梁的旺度為廟，主富貴雙全，多才多藝。

		  if( $you->{sex} eq 1 ){

		      if($you->{ziwei}->{"天梁"}->{bright} eq "廟" ){
			    push @{$res->{$k}->{"additional"} },qq|      主富貴雙全，多才多藝。|;
		      }
# 命宮有：左輔、右弼，幫夫教子，心慈好施而爽直。

		      if($self->has_stars(  stars=>["左輔","右弼"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|   幫夫教子，心慈好施而爽直。|;
		      }
		  }



	      }


		################   七殺   ####################  
		if($k eq "七殺"){
		  $res->{$k}->{"main"}.= qq|
		      容貌：眉斜目大、暴虎馮河。

		      性格：喜怒不一、性急不常。雖有權勢、稍嫌激烈。

		      人格類型：開創型 (判斷力)。

		      個性特質：威勇、重情、講義、果決、肅殺 、剛烈、暴躁、戰出、權威、感情用事。在必要時，很快下決策並達成協議。

		      愛情：率性而為。

		      優點：胸襟磊落，不畏挑戰，舉止大方，反應靈敏，行俠仗義，不拘小節。
		      缺點：個性衝動，率性而為，冒險投機，不計後果，言語易起衝突，難以分辨善惡，歷經滄桑，孤獨難免。

			主成敗、管生死權柄等，象徵「威勇」，具有運用帷幄的能力，擁有理智而獨立、衝鋒陷陣、冒險犯難的特性，是一個言出必行的人，說到做到，讓猶豫不決的事，都能很快的得到解決。性凶狠積極、是孤剋之星、故精神空虛，六親緣薄。風格明快，乾淨俐落。適應力極強，對事物拿得起放得下。相當具有正義感，看不慣因循苟且，不安於室，慾望深。七殺主軍憲，具威嚴，星性沉吟，喜怒無常。在人命身，主心情反覆不定，有憂鬱與納悶的心態，做事較容易衝動。坐命少年時期必坎坷，身體較會有毛病。七殺不僅是講求實用，更會講求名牌。七殺對於金錢的慾望頗高，賺大錢的機率是有，可是衝鋒陷陣而陣亡的機會更高！事業心重的他，很容易因為做事果斷、迅速，而失去了好姻緣，通常他喜歡的對象不是工作上的得力助手就是同等級的競爭對手。刑剋重，宜拜養父母。辰，戌宮為天羅地網，反而有利於七殺開展。最喜魁鉞與左右四吉星。除祿星外，能化七殺之惡，乃紫微也，所謂化殺為權。


			喜怒不常，做事多疑。
			眼神有力，不怒而威，性情倔強，外表果決，但口硬心軟，少年辛苦，白手起家。情緒不穩定，有衝動潛能，教育程度能改正。不拘小節，但擅理財。一生大變化的機率很高。利軍警武職。有離鄉背井機會，或從事與海外有關之工作。
			身態：主面色白或紅黃色。面型長方者或瘦長者較多；方面較少。中等身材。不怒而有威。
			個性：為眾人所敬服，一生事業性重，處事外表果決，內實進退考慮，富計謀善策畫。臉型方長，體高身壯，剛毅之相。性暴急，多爭競，具獨立氣概，不喜他人管束。敢衝、敢冒險、敢面對危難，對因難有勇氣一一克服，但困難解決後，即無興趣守成。喜怒哀樂形於色，狂風兩後瞬即天晴。必須腳踏實地，如實業工廠等方面發展，投機不宜。在政界或軍界、警界必經過一次風浪波折折轉變。在實業、在工廠亦必遭有顛覆停頓或致於破產之難關發生，但不像投機的一蹶不振。在短時期內，便能東山再起，重振旗鼓。	      		

|;


		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }


# ＊ 七殺寅申子午，一生爵祿榮昌。（為七殺朝鬥格。吉星湊，合此格，加煞不是）
		  if($self->born(  time=>["寅","申","子","午"] ) && $self->has_sixlucky() && !$self->has_sixghost() ){
		      push @{$res->{$k}->{"additional"} },qq|一生爵祿榮昌。|;
		  }
# ＊ 朝斗仰斗，爵祿榮昌。（七殺守命，旺宮是也。如寅申子午為朝鬥，三方為仰鬥，入格者富貴）
		  if($you->{ziwei}->{$k}->{bright} eq "旺" && $self->born(  time=>["寅","申","子","午"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|爵祿榮昌。|;
		   }
		   
# ＊ 七殺臨身終是夭。（七殺臨身命，陷地加凶，依此斷）
		  if($you->{ziwei}->{$k}->{bright} eq "陷" && $self->has_sixghost() ){
		      push @{$res->{$k}->{"additional"} },qq|終是夭。|;
		   }
# ＊ 七殺守命，廟旺，有謀略，見紫微，加見諸吉，必為大將。
		  if($you->{ziwei}->{$k}->{bright} eq "廟" && $you->{ziwei}->{$k}->{bright} eq "旺") {
		      push @{$res->{$k}->{"additional"} },qq|有謀略。 |;
		      
		      		  if( $self->has_jiahui(  stars=>["紫微","文昌","文曲","左輔","右弼","天魁","天鉞"] )  ){
				      push @{$res->{$k}->{"additional"} },qq|必為大將。|;
				  }
		  
		   }
# ＊ 七殺守命，廟旺，得左右昌曲拱照，掌生殺之權，富貴出眾。
		  if($you->{ziwei}->{$k}->{bright} eq "廟" && $you->{ziwei}->{$k}->{bright} eq "旺" ){

		      
		      		  if( $self->has_jiahui(  stars=>["文昌","文曲","左輔","右弼"] )  ){
				      push @{$res->{$k}->{"additional"} },qq|掌生殺之權，富貴出眾。|;
				  }
				  
	      }
		  
# ＊ 七殺入命身宮，見吉，亦必曆受艱辛。不見吉化必夭折。
		      
	      if( $self->has_jiahui(  stars=>@sixlucky )  ){
		  push @{$res->{$k}->{"additional"} },qq|亦必曆受艱辛。 |;
	      }else{
	      	push @{$res->{$k}->{"additional"} },qq|化必夭折。|;
	      }
# ＊ 七殺陷地，巧藝謀生。
		  if($you->{ziwei}->{$k}->{bright} eq "陷" && $self->has_sixghost() ){
		      push @{$res->{$k}->{"additional"} },qq|爵祿榮昌。|;
		   }
# ＊ 七殺廉貞同宮，主殘廢，又主癆病。
		  if( $self->has_stars(  stars=>["廉貞"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|主殘廢，又主癆病。|;
		  }
# ＊ 七殺廉貞同位，路上埋屍。（為殺拱廉貞格，會破軍於遷移亦然。若陷地加化忌尤凶）
		  if( $self->has_stars(  stars=>["廉貞"] ) && $self->has_stars( pos=>($self->{pos}+6)%12, stars=>["破軍"]) ){
		      push @{$res->{$k}->{"additional"} },qq|路上埋屍。|;
		      
		       if($you->{ziwei}->{$k}->{bright} eq "陷" && $self->has_sixghost() ){
			  push @{$res->{$k}->{"additional"} },qq|    尤凶。|;
		      }
		  }
# ＊ 七殺、破軍宜出外。（此二星會身命於陷地，主諸般手藝能精，出外可也。殺寅申，破巳亥論）
		  if( $self->has_stars(  stars=>["廉貞"] ) && $self->has_stars( pos=>($self->{pos}+6)%12, stars=>["破軍"]) ){
		      push @{$res->{$k}->{"additional"} },qq|宜出外。|;
		      
		       if($you->{ziwei}->{$k}->{bright} eq "陷" && $self->has_sixghost() ){
			  push @{$res->{$k}->{"additional"} },qq| 主諸般手藝能精，出外可也。|;
		      }
		  }


# ＊ 女命，七殺沉吟福不榮。（男有威權，女無所施）

		  if( $you->{sex} eq 1 ){
		      push @{$res->{$k}->{"additional"} },qq|七殺沉吟福不榮。（男有威權，女無所施）|;
		      }
# ＊ 七殺重逢四煞，腰駝背曲，陣中亡。（殺與火鈴，主陣亡。又有疾厄）
		  if( $self->has_stars(  stars=>@fourghosts ) ){
		      push @{$res->{$k}->{"additional"} },qq|腰駝背曲，陣中亡。（殺與火鈴，主陣亡。又有疾厄）|;
		  }
# ＊ 七殺代表威權謀略。
		      push @{$res->{$k}->{"additional"} },qq|威權謀略。|;
# ＊ 七殺以事業為精神寄託。
		      push @{$res->{$k}->{"additional"} },qq|以事業為精神寄託。|;
# ＊ 七殺為孤獨星六親緣薄，朋友少。
		      push @{$res->{$k}->{"additional"} },qq|為孤獨星六親緣薄，朋友少。|;
# ＊ 七殺加會左輔、右弼，有實權之主管，有貴人助。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|有實權之主管，有貴人助。|;
		  }
# ＊ 七殺加會文昌、文曲，文武兼備，但遇事猶豫不決。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|文武兼備，但遇事猶豫不決。|;
		  }
# ＊ 七殺加會天魁、天鉞，有利事業發展成功。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|有利事業發展成功。|;
		  }
# ＊ 七殺加會科、權、祿，得財，企業管理人才。
		  if($self->has_jiahui_huaji( star=>$k, stars=>[ "科","權","祿"] ) ){
			  push @{$res->{$k}->{"additional"} },qq|    得財，企業管理人才。|;
			

		   }
# ＊ 七殺加會火星或鈴星錢財不聚，意氣用事。
		  if( $self->has_stars(  stars=>["火星"] )  ||  $self->has_stars(  stars=>["鈴星"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|財不聚，意氣用事。|;
		  }
# ＊ 七殺加會擎羊、陀羅，事業受阻。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|事業受阻。|;
		  }
# ＊ 七殺加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌易生意外之災。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|易生意外之災。|;
		  }

# ＊ 大小限遇七殺星主事業變動。
# ＊ 七殺、破軍專依羊鈴之虐。
# ＊ 殺臨絕地，會羊陀，天年夭似顏回。
# ＊ 七殺羊陀會生鄉，屠宰之人。（或主貧且賤）
# ＊ 七殺逢羊陀於疾厄，終身殘疾。縱使一生孤獨，也應壽年不長。
# ＊ 七殺單居福德，女人切忌，賤無疑。
# ＊ 七殺臨身命，流年羊陀，主災傷。（逢紫微、天相、祿存，可解）
# ＊ 七殺羊鈴，流年白虎，刑戮災迍。
# ＊ 七殺流羊遇官符，離鄉遭配。（歲限俱到）
# ＊ 七殺守照，歲限擎羊，午生人安命卯酉宮，主凶亡。（余宮亦忌。命限三合七殺流羊照命，即七殺重逢）

# 七殺的旺度為廟，雖有破敗災禍病災，但仍許富貴。
		  if($you->{ziwei}->{$k}->{bright} eq "廟" ){
		      push @{$res->{$k}->{"additional"} },qq|雖有破敗災禍病災，但仍許富貴。|;
		   }

# 七殺的旺度為陷，或死於兵荒馬亂，或陣亡災死，或則疾病開刀，性情倔強，剛愎自用，處事霸道，行為凶橫而壽夭。
		  if($you->{ziwei}->{$k}->{bright} eq "陷" ){
		      push @{$res->{$k}->{"additional"} },qq|或死於兵荒馬亂，或陣亡災死，或則疾病開刀，性情倔強，剛愎自用，處事霸道，行為凶橫而壽夭。|;
		   }

# 命宮的宮位是「巳、亥」，多得貴人提攜，青雲直上，而能富能貴。
		  if($self->born(  time=>["巳","亥"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|多得貴人提攜，青雲直上，而能富能貴。|;
		  }

# 命宮的宮位是「寅、申」，多清高，如為眾人師表、幫會領袖，獨負其責、獨當一面者。
		  if($self->born(  time=>["寅","申"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|多清高，如為眾人師表、幫會領袖，獨負其責、獨當一面者。|;
		  }

# 命宮有：紫微星、天府、祿存、化祿、化權、化科、六吉，得群眾擁護，在國家為大將之材，極品之貴，在商為工業界之領袖，名震他邦。
		  if($self->has_stars(  stars=>["紫微","天府","祿存"] ) || $self->has_huaji( star=>$k, stars=>[ "祿","權","科"] )  | $self->has_sixlucky() ){
		      push @{$res->{$k}->{"additional"} },qq|得群眾擁護，在國家為大將之材，極品之貴，在商為工業界之領袖，名震他邦。|;
		  }

# 命宮有：六煞、天刑、大耗，主刑剋傷害，福不全，能富貴者，則配偶有刑剋分離者，或子女無出者，或多女少男者，或疾病纏身者；如骨肉無缺，身體健康者，則又不能富不能貴矣。
		
		  if( $self->has_sixghost() || $self->has_stars(  stars=>["天刑","大耗"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|主刑剋傷害，福不全，能富貴者，則配偶有刑剋分離者，或子女無出者，或多女少男者，或疾病纏身者；如骨肉無缺，身體健康者，則又不能富不能貴矣。|;

		  }
# 命宮有：天空、地劫、大耗，投機有傾家之憂，且少有恢復的機會。
		  if( $self->has_stars(  stars=>["天空","地劫","大耗"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|投機有傾家之憂，且少有恢復的機會。|;
		  }

# 命宮有：祿存、化祿，或命宮有右輔、右弼、天魁、天鉞，雖亦有困難遭遇，但能得眾人之助力原諒，逢凶化吉，迅速轉機。
		    if(( $self->has_stars(  stars=>["祿存"] ) ||  $self->has_huaji( star=>$k, stars=>[ "祿"] ) ) ||  $self->has_stars(  stars=>["右輔","右弼","天魁","天鉞"] )){
		      push @{$res->{$k}->{"additional"} },qq|雖亦有困難遭遇，但能得眾人之助力原諒，逢凶化吉，迅速轉機。|;
		    }



	      }



		################   破軍   ####################  
		if($k eq "破軍"){
		  $res->{$k}->{"main"}.= qq|
 容貌：眉寬唇厚、行坐腰斜。

性格：寡合爭強、好賭嗜補。投機性大、消耗頗多。

人格類型：開創型 (主動性)。

個性特質：破壞、變化、消耗、顛覆 、破損、賭博、投機、飄盪、膽大、懦弱、矛盾。積極影響事物，而不是消極接受。

愛情：求新求變。

優點：身體力行，求新求變，吃苦耐勞，勇於任事，不畏橫暴，善惡分明，反應迅捷，坦白直率。
缺點：我行我素，喜新厭舊，個性倔強，反抗心重，不易合作，欠缺彈性，遇事每多辯駁，翻臉六親不認。

破軍為"戰將"，但他是比七殺低一等，七殺可以受命於皇帝而堂堂正正，而如果破軍直接受命於帝君，便有點格格不入，因此紫微破軍的組合必要一個良好的紫微就比較穩妥。有魄力，是一個事必躬親的星曜，象徵「耗」的現象，主禍福，行事往往在一念之間取決，有我行我素的強烈主觀意識。破壞、殘暴、權力、獨裁、消耗，先破壞再建設，開展性極強，適宜做事業的開路先鋒。常因衝過了頭，反而製造了許多問題。武斷，比較霸道。私心較重，容易翻臉。不宜守成。於人命身，多主心情反覆不定，具有冒險患難的精神。此星六親緣份較淡，夫妻、子女緣份虛而不實，重義氣，離鄉背井之命格。在心身而言，多奔忙勞苦，一生變動起伏較大，與人寡合，對現實有不滿的心態。破軍星個性暴躁、衝動、勇敢，具有冒險性，也為破軍帶來波動的命格，然而其正直、堅毅、領導力也是受到許多人喜愛的原因之一。破軍變動的結果，不論好與壞、成與敗，必須辛苦耕耘，歷經挫折與打擊。破軍守命通常是閒不住的人，意念多多，最好是一天有四十八小時。唯一能制服他的是祿存，化祿次之，沒有祿的破軍是消耗戰。除了太陰以及貪狼之外，破軍也是美人星，大眼美女，但不利六親。破軍所在宮位，常為破局所在，該宮位極不穩定。不宜守成，落天羅地網最佳。消費的型態是很極端的，憑感覺就是了。不愛與人說話、神密感重的破軍，其實是個很情緒化的人，所以常會嚇到另一半。因此在感情的路上，可能要多經過一些人生的磨鍊，才能讓他學會控制自己的情緒，不然以他那不服輸的個性，就算得理也不會饒人。因為他的生活重心並不是放在愛情上，所以才會有破軍的人晚婚較好的說法。


				    有追求刺激的心態，敢於冒險，不願意臣服於人受人管束。疏骨肉，仇六親(即聚少離多或過房，認領)，一生有較大幅度之變動，但感情豐富，勇敢正直。
	      兇焰甚高，惟紫微，天梁可制。適合多變(開創性職業，及機動性錢財，或從事武職，唯不利女命)。
	      身態：主人面色青黃、長面型，胖瘦不一。身材五短，背厚眉寬，行坐腰斜，性剛寡合，任性狂傲；或破相，或近視，或口吃不清，或產時不足月，或難產。 
	      個性：不重外表，遇事多疑，投機冒險，喜新事物，喜破壞現狀，加以變化改革，但亦易受環境影響。言語不拘，或具煽惑，或敢說罵，直至他人為之撼心動容。 

		      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

		  if($you->{ziwei}->{$k}->{bright} eq "廟" &&  $self->born(  time=>["子","午"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|顯貴，棄祖離鄉則吉。|;
		   }
		


# ＊ 破軍子午宮，無煞，甲癸生人，官資清顯，位至三公。（為英星入廟格。丁己生人次之，丙戊生人主困）
		  if($self->born(  time=>["子","午"] ) && !$self->has_sixghost() && $self->born(  time=>["甲","癸"] )){
		      push @{$res->{$k}->{"additional"} },qq|官資清顯，位至三公。（為英星入廟格。丁己生人次之，丙戊生人主困）|;
		  }
# ＊ 破軍子午宮，丙戊寅申生人，孤單殘疾，雖富貴不耐久，夭折。
		  if($self->born(  time=>["子","午"] ) &&  $self->born(  time=>["丙","戊","寅","申"] )){
		      push @{$res->{$k}->{"additional"} },qq|孤單殘疾，雖富貴不耐久，夭折。|;
		  }
# ＊ 破軍辰戌丑未宮，丙戊生人，富貴。
		  if($self->born(  time=>["辰","丑","未"] ) &&  $self->born(  time=>["丙","戊"] )){
		      push @{$res->{$k}->{"additional"} },qq|富貴。|;
		  }
# ＊ 破軍一曜性難明。（男女命論）
		      push @{$res->{$k}->{"additional"} },qq|曜性難明。（男女命論）|;

# ＊ 破軍廉貞於卯酉陷地，遇羊陀火鈴，主官非、爭鬥、疾病。
		  if($self->born(  time=>["辰","丑","未"] ) &&  $self->has_jiahui(  stars=>["火星","鈴星","擎羊","陀羅"] )){
		      push @{$res->{$k}->{"additional"} },qq|主官非、爭鬥、疾病。|;
		  }
# ＊ 武曲破軍同宮，入財鄉，東傾西敗。
		  if($self->has_stars(  stars=>["武曲"] ) ){
		      push @{$res->{$k}->{"additional"} },qq|入財鄉，東傾西敗。|;
		  }
# ＊ 破軍昌曲同宮於寅，主貴。
		  if($self->has_stars(  stars=>["文昌","文曲"] )  && $self->born(  time=>["寅"] )){
		      push @{$res->{$k}->{"additional"} },qq|主貴。|;
		  }
# ＊ 破軍昌曲同宮，一生貧士。
		  if($self->has_stars(  stars=>["文昌","文曲"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|一生貧士。|;
		  }

# ＊ 破軍羊陀同宮，主有殘疾。
		  if($self->has_stars(  stars=>["擎羊","陀羅"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|主有殘疾。|;
		  }
# ＊ 破軍火鈴，奔波勞碌，官非爭鬥。
		  if($self->has_stars(  stars=>["火星","鈴星"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|奔波勞碌，官非爭鬥。|;
		  }
# ＊ 破軍在命身宮，陷地，棄祖離宗。
		  if($you->{ziwei}->{$k}->{bright} eq "陷" ){
		      push @{$res->{$k}->{"additional"} },qq|棄祖離宗。|;
		   }

# ＊ 破軍代表投機，消耗，變動。
		      push @{$res->{$k}->{"additional"} },qq|代表投機，消耗，變動。|;
		      
# ＊ 破軍為北斗星，為人投機性重。
		      push @{$res->{$k}->{"additional"} },qq|代表投機，消耗，變動。|;
		      
		      
# ＊ 破軍為孤獨星，六親緣薄，朋友少。
		      push @{$res->{$k}->{"additional"} },qq|為孤獨星，六親緣薄，朋友少。|;
		      
		      
# ＊ 破軍加會左輔、右弼，有管理氣魄，有貴人助。
		  if($self->has_stars(  stars=>["左輔","右弼"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|有管理氣魄，有貴人助。|;
		  }
# ＊ 破軍加會文昌、文曲，感情不定，錢財不聚。
		  if($self->has_stars(  stars=>["文昌","文曲"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|感情不定，錢財不聚。|;
		  }
# ＊ 破軍加會天魁、天鉞，機運多。
		  if($self->has_stars(  stars=>["天魁","天鉞"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 破軍化祿：多花費，變動，易有得力同事，子女，夫妻。
		  if(  $self->has_huaji( star=>$k, stars=>[ "祿"]) ){
		       push @{$res->{$k}->{"additional"} },qq|多花費，變動，易有得力同事，子女，夫妻。|;
		  }
		  
# ＊ 破軍加會科、權、祿，得財，可享幸福生活，企業管理人才。
		  if(  $self->has_huaji( star=>$k, stars=>[ "祿"] )){
		       push @{$res->{$k}->{"additional"} },qq|多花費，變動，易有得力同事，子女，夫妻。|;
		  }
# ＊ 破軍加會火星或鈴星錢財不聚，意氣用事。
# ＊ 破軍加會擎羊、陀羅，發展不大。
# ＊ 破軍加會火星、鈴星、擎羊、陀羅、地空、地劫，化忌，錢財易破，疾病，苦惱。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|錢財易破，疾病，苦惱。|;
		  }
		  
# ＊ 大小限遇破軍星主事業變動。
# ＊ 破軍昌曲逢，刑克多勞碌。（破軍在卯酉辰戌守命，雖得文昌文曲，亦非全吉。應主刑克勞碌）
# ＊ 破軍、貪狼逢祿馬，男流蕩，女多淫。
# ＊ 破軍羊陀官祿位，到處乞求。
# ＊ 破軍在兄弟宮，骨肉參商。
# ＊ 破軍在夫妻宮，主不正，婚姻進退。
# ＊ 破軍在子女宮，先損後招。
# ＊ 破軍在財帛宮，如湯澆雪。
# ＊ 破軍在疾厄宮，致羸黃之疾。
# ＊ 破軍在遷移宮，奔走無力。
# ＊ 破軍在僕役宮，謗怨逃走。
# ＊ 破軍在官祿官，主清貧。
# ＊ 破軍在田宅宮，祖業破蕩。
# ＊ 破軍在福德宮，多災。
# ＊ 破軍在父母宮，刑克，破相。

# 命宮的宮位是「辰、戌」，主人一生中必有非常之災遇，或特殊之疾病，拖延頗久，屬腦神經、心臟、腎臟或腸胃病等。為人有毅力，有專長，愛藝術。但一生風波頗多，不守祖業。並主刑剋配偶，富而不貴，有虛名。 
		  if($self->born(  time=>["辰","戌"] )  ){
		      push @{$res->{$k}->{"additional"} },qq|主人一生中必有非常之災遇，或特殊之疾病，拖延頗久，屬腦神經、心臟、腎臟或腸胃病等。為人有毅力，有專長，愛藝術。但一生風波頗多，不守祖業。並主刑剋配偶，富而不貴，有虛名。 |;
		  }
		 
# 破軍的旺度為陷，性剛寡合，好強好爭。 
		  if($you->{ziwei}->{$k}->{bright} eq "陷" ){
		      push @{$res->{$k}->{"additional"} },qq|性剛寡合，好強好爭。 |;
		   }

# 破軍的旺度為廟，忠厚善良，旺地性耿直，處事有恆、有毅力。 
		  if($you->{ziwei}->{$k}->{bright} eq "廟" ){
		      push @{$res->{$k}->{"additional"} },qq|忠厚善良，旺地性耿直，處事有恆、有毅力。 |;
		   }
# 命宮有：紫微星，命宮的宮位為「未」，主得意外之財，或突遇貴人，平昇三級。 
		  if($self->has_stars(  stars=>["紫微"] ) && $self->born(  time=>["未"] )){
		      push @{$res->{$k}->{"additional"} },qq|主得意外之財，或突遇貴人，平昇三級。|;
		  }

# 女命注重外表，且虛榮、浪費、神經質。 

		  if( $you->{sex} eq 1 ){
		      push @{$res->{$k}->{"additional"} },qq|注重外表，且虛榮、浪費、神經質。 |;
# 命宮的宮位是「子、午」，主福厚祿重，旺夫益子，惟以遲婚為宜。 
			if($self->born(  time=>["子","午"] ) ){
			    push @{$res->{$k}->{"additional"} },qq|      主福厚祿重，旺夫益子，惟以遲婚為宜。 |;
			}
# 命宮的宮位是「巳、亥」，性情剛強，有丈夫志。 
			if($self->born(  time=>["巳","亥"] )  ){
			    push @{$res->{$k}->{"additional"} },qq|      性情剛強，有丈夫志。 |;
			}
# 命宮的宮位是「寅、申」，刑夫剋子，早離父母，重繼他姓，自食其力，以偏室較宜，否則離剋多次，又多終年不嫁者。
			if($self->born(  time=>["寅","申"] )  ){
			    push @{$res->{$k}->{"additional"} },qq|      刑夫剋子，早離父母，重繼他姓，自食其力，以偏室較宜，否則離剋多次，又多終年不嫁者。|;
			}
		  }

	      }


		###########verify  祿存 ： 祿存入六親宮(福德宮、父母宮、命宮、兄弟宮、夫妻宮、以及子女宮)主爭執無緣。祿存、化祿入財宮，有利財源。
		################   祿存   ####################  
		if($k eq "祿存"){
		  $res->{$k}->{"main"}.= qq|

 容貌：餘裕豐滿。

性格：心慈餘裕、多學多能。

個性特質：博學、富貴、脆弱、財富、波折多。

孤星，化氣為貴，財星，主祿食，解厄，也是一顆貴人星。是災害解厄制化之星、是錦上添花之星。是財星，宜入命、財宮位，衣食不缺，不愁吃穿。比較容易會被別人欺負，容易孤獨無依，個性上會較為孤僻。又叫得物星，就事情來說表示一定會發生或是得到。能解破軍、廉貞、巨門之凶性。最怕天空、地劫，叫做祿逢冲破，逢化忌也主破失不吉。獨坐則晚發，旁有羊陀夾制，發達較晚。穩定之助力，可托出財星之力。如見武曲化祿成守財奴；如只得祿存守命宮，不懂運財。

		      忠誠厚重，大方得體，若無主星則有孤僻。財祿(主宮)。化氣為富。貴人。解厄。聰明。上進。耐勞。陰孤。緣。   		
      
|;


		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 祿存象徵財星。
			   push @{$res->{$k}->{"additional"} },qq|象徵財星|;
# ＊ 祿存為北斗壽星為人多仁慈，穩重。
			   push @{$res->{$k}->{"additional"} },qq|北斗壽星為人多仁慈，穩重。|;
# ＊ 祿存加會左輔、右弼，有管理能力，財運多。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力，財運多。|;
		  }
# ＊ 祿存加會文曲，感情豐富，有才藝，為人秀麗。
		  if( $self->has_jiahui(  stars=>["文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝，為人秀麗。|;
		  }
# ＊ 祿存加會天魁、天鉞，財運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|財運多。|;
		  }
# ＊ 祿存加會科、權、祿，得財，企業管理人才。
		  if(  $self->has_huaji( star=>$k, stars=>[ "科","權","祿"] )){
		       push @{$res->{$k}->{"additional"} },qq|得財，企業管理人才。|;
		  }
# ＊ 祿存加會地空、地劫，錢財會賺會花。
		  if( $self->has_jiahui(  stars=>["地空","地劫"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財會賺會花。|;
		  }
# ＊ 祿存加會擎羊、陀羅，錢財不聚，有才藝之人。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，有才藝之人。|;
		  }
# ＊ 祿存加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌感情不順，易被人欺侮，有才藝之人。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|感情不順，易被人欺侮，有才藝之人。|;
		  }
		  
# ＊ 大小限遇祿存有錢財上的增加。
# 祿存入六親宮(福德宮、父母宮、命宮、兄弟宮、夫妻宮、以及子女宮)主爭執無緣。祿存、化祿入財宮，有利財源。


# 祿存、化祿入財宮，有利財源。	   
		  if($you->{ziwei}->{$k}->{hua_ji} eq "忌" ){
		      push @{$res->{$k}->{"additional"} },qq|主財由何處去。|;
		  }


	      }

 ###########verify 天馬 ： 財祿。衝動。入財宮，賺變動財。
		################   天馬   ####################  
		if($k eq "天馬"){
		  $res->{$k}->{"main"}.= qq|
		    好動不耐靜。

		      好動，怕空亡之鄉。驛馬(主宮)。財祿。衝動。
        
		入命身宮主武顯，財星，主驛馬，遷動，司祿。個性好動坐不住，沒有定性、比較活潑、喜歡往外面跑。於疾病主流行性病，男易遺漏，女性得之主容易月事不順調。心性主外，善於交際。羊陀逢之，奔波忙碌，火鈴逢之，宜外地發達或武職為宜。最喜逢祿存與化祿。動能，上進，精進，努力。天馬星遇上天空星則表示天馬行空，你一輩子注定會飄蕩，而且沒有目標。
		|;


		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }



# ＊ 天馬臨命身宮，謂之驛馬，主好動。喜祿存紫府昌曲守照為吉。
		  if( $self->has_jiahui(  stars=>["祿存","紫微","文曲","文昌"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|謂之驛馬，主好動。 為吉。|;
		  }
		  	      
# ＊ 天馬祿存同宮，謂之祿馬交馳，主大吉利。（忌見煞羊火截路空亡及死絕之鄉，多主勞苦）
		  if( $self->has_stars(  stars=>["祿存"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|謂之祿馬交馳，主大吉利。|;
		  }

# ＊ 天馬遇亡，終身奔走。
		  if( $self->has_jiahui(  stars=>["天空","亡神"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|終身奔走。|;
		  }
		  	
# ＊ 女命，天梁遇馬，賤而且淫。（天馬坐命，三合遇天梁合照是也）
		  if( $you->{sex} eq 1 ){
			if( $self->has_shanhe(  stars=>["天梁"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|終身奔走。|;
		  }
		   
		}
# ＊ 天馬代表變動，變化。
			   push @{$res->{$k}->{"additional"} },qq|變動，變化。|;
# ＊ 天馬為人多好動，喜加會祿存，富甲一方。
			   push @{$res->{$k}->{"additional"} },qq|人多好動|;
		  if( $self->has_jiahui(  stars=>["祿存"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|富甲一方。|;
		  }
# ＊ 天馬加會左輔、右弼，為人活潑，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|為人活潑，有管理能力。|;
		  }
# ＊ 天馬加會文曲，感情豐富，有才藝，異性緣佳。
		  if( $self->has_jiahui(  stars=>["文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝，異性緣佳。|;
		  }
# ＊ 天馬加會天魁、天鉞，機運多，異性緣佳。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多，異性緣佳。|;
		  }
# ＊ 天馬加會科、權、祿，易得財，企業管理人才。
		  if(  $self->has_huaji( star=>$k, stars=>[ "科","權","祿"] )){
		       push @{$res->{$k}->{"additional"} },qq|得財，企業管理人才。|;
		  }
# ＊ 天馬加會火星或鈴星為人衝動。
		  if( $self->has_jiahui(  stars=>["火星"])  || $self->has_jiahui(  stars=>["鈴星"])) {
			   push @{$res->{$k}->{"additional"} },qq|為人衝動。|;
		  }
# ＊ 天馬加會擎羊、陀羅，出外不利。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多，異性緣佳。|;
		  }
# ＊ 天馬加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌多不利遠行。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|不利遠行。|;
		  }
# ＊ 大小限遇天馬星外出變動機會多。
# ＊ 天馬坐妻宮，富貴還當封贈。	
# ＊ 天馬逢空亡死絕，災病不利。

   }


		 ###########verify 左輔 ：入財宮，靠助力獲利。
		################   左輔   ####################  
		if($k eq "左輔"){
		  $res->{$k}->{"main"}.= qq|
溫和得力的好幫手。

 容貌：溫良端正。

性格：寬恕好施、計有機謀。

個性特質：實質上的幫助、忙碌、多助的、加強的、義氣。


		      敦厚溫良，大方慷慨，不喜獨坐。
輔佐。貴人。隨和。驛馬。細姨。聰明。輔弼之力，對宮→夾→同宮。

   貴人星，輔佐(輔助)星。隱重，圓巧慷慨，大多隨和，風流，有上進心、有抱負。聰明機靈、有謀略、忠厚耿直、寬厚量大、踏實、有包容力、重復、人緣好。獨坐命宮無主星，宜重拜養父母。落夫妻宮，配偶容易有婚外情。對過往感情仍時常銘記在心，重情惜情。吉助力（雙星同見，助力不絕）；會見凶星也不會助紂為虐。 主〝善〞，你幫助了別人也會得到別人的幫助。

      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 左輔守命，紫府權祿三合拱照，主文武大貴。
		  if( $self->has_shanhe(  stars=>["紫府"])  &&   $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|主文武大貴。|;
		  }
# ＊ 左輔守命，紫府相機昌日月貪武會合，更有右弼同宮，富貴不小，火忌衝破則富貴不久。
		  if( $self->has_shanhe(  stars=>["紫府","天相","天機","文昌","太陽","太陰","武曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|主文武大貴。|;
		  }
		  
# ＊ 左輔守命，羊陀火鈴湊合，加巨門七殺天機為下格。
		  if( $self->has_shanhe(  stars=>["擎羊","陀羅","火星","鈴星"]) &&  $self->has_jiahui(  stars=>["巨門","七殺","天機"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|下格。|;
		  }
		  
		  
# ＊ 左輔廉貞擎羊同宮，作盜賊且主遭傷。
		  if( $self->has_stars(  stars=>["廉貞","擎羊"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|作盜賊且主遭傷。|;
		  }
# ＊ 左府同宮，尊居萬乘。（二星同宮辰戌安命，三方吉化拱沖，必居極品之貴）
		  if( $self->has_stars(  stars=>["天府"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|尊居萬乘。（二星同宮辰戌安命，三方吉化拱沖，必居極品之貴）|;
			  
			   
		  }
# ＊ 左輔文昌會吉星，尊居八座。（二星坐守於身命，三主吉拱方論。加煞不是）
		  if( $self->has_stars(  stars=>["天府"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|尊居萬乘。（二星同宮辰戌安命，三方吉化拱沖，必居極品之貴）|;
			  
			   
		  }
		  
# ＊ 左輔代表忠厚。 
			   push @{$res->{$k}->{"additional"} },qq|忠厚。 |;
			  
			  
# ＊ 左輔為北斗帝極善星為人作事盡職，人緣佳。
			   push @{$res->{$k}->{"additional"} },qq|為北斗帝極善星為人作事盡職，人緣佳。|;
			  
# ＊ 左輔加會右弼，有管理能力。
		  if( $self->has_jiahui(  stars=>["右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
		  
# ＊ 左輔加會文昌，文曲，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
		  
# ＊ 左輔加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 左輔化科：有才華，有助力。
		  if( $self->has_huaji( star=>$k, stars=>[ "科"] )){
		       push @{$res->{$k}->{"additional"} },qq|：有才華，有助力。|;
		  }
# ＊ 左輔加會科、權、祿，得財利，企業管理人才。
		  if( $self->has_shanhe(  stars=>["紫府"])  &&   $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|主文武大貴。|;
		  }
# ＊ 左輔加會火星或鈴星多變動，勇於面對問題來解決。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|多變動，勇於面對問題來解決。|;
		  }
# ＊ 左輔加會擎羊、陀羅，感情多波折，勇於面對問題來解決。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情多波折，勇於面對問題來解決。|;
		  }
# ＊ 左輔加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌多感情多波折，勇於面對問題來解決。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|多感情多波折，勇於面對問題來解決。|;
		  }
		  
# ＊ 大小限遇左輔星事業順利。
# ＊ 左輔在夫妻宮，主人定二婚。

		  if($self->has_stars(  stars=>["七殺","破軍","貪狼"] )){
		      push @{$res->{$k}->{"additional"} },qq|主波折。|;
		  }

	      }
# 		 ###########verify 右弼 : 入財宮，靠助力獲利。
		################   右弼   ####################  
		if($k eq "右弼"){
		  $res->{$k}->{"main"}.= qq|

優秀助理兼大眾情人。

 容貌：溫良端正。

性格：寬恕好施、計有機謀。

個性特質：精神上的幫助、忙碌、多助的、加強的、感情。

		      心懷耿直，寬恕好施，不喜獨坐。
輔佐。貴人。隨和。驛馬。細姨。聰明。輔弼之力，對宮→夾→同宮。

 貴人星，輔佐(輔助)星。專制，聰明、能幹、機智，有上進心有抱負。重感情。主精通文墨、個性耿直、好施濟、做事小心謹慎有謀略。獨坐命宮無主星，宜重拜養父母。落夫妻宮，配偶容易有婚外情。對過往感情仍時常銘記在心，重情惜情。吉助力（雙星同見，助力不絕）；會見凶星也不會助紂為虐。 你幫助了別人也會得到別人的幫助。主〝善〞。
      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }


# ＊ 右弼守命，會紫微府相昌曲，終身福厚。
		  if( $self->has_jiahui(  stars=>["紫府","天相","天府","文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|終身福厚。|;
		  }
		  
# ＊ 右弼紫府同宮，財官雙美，文武雙全。
		  if($self->has_stars(  stars=>["紫府","天府"] )){
		      push @{$res->{$k}->{"additional"} },qq|財官雙美，文武雙全。|;
		  }

# ＊ 右弼天相福來臨。（諸宮遇福，醜未亥三宮不貴，縱貴不久遠，若卯酉二陷宮，少稱心遂意）
		  if($self->has_stars(  stars=>["天相"] )){
		      push @{$res->{$k}->{"additional"} },qq|福來臨。（諸宮遇福，醜未亥三宮不貴，縱貴不久遠，若卯酉二陷宮，少稱心遂意）|;
		  }
# ＊ 右弼廉貞擎羊同宮，作盜賊且主遭傷。
		  if($self->has_stars(  stars=>["擎羊","廉貞"] )){
		      push @{$res->{$k}->{"additional"} },qq|作盜賊且主遭傷。|;
		  }



# ＊ 右弼代表豁達。
		      push @{$res->{$k}->{"additional"} },qq|豁達。|;
# ＊ 右弼為北斗帝極善星為人樂觀，好文學。
		      push @{$res->{$k}->{"additional"} },qq|為人樂觀，好文學。|;
# ＊ 右弼加會左輔，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
		  
# ＊ 右弼加會文昌，文曲，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
		  
# ＊ 右弼加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 右弼化科：善思考，有助力。
		  if($self->has_huaji( star=>$k, stars=>[ "科"] )){
		       push @{$res->{$k}->{"additional"} },qq|善思考，有助力。|;
		  }
		  
# ＊ 右弼加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 右弼加會火星或鈴星，多變動，勇於面對問題來解決。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|多變動，勇於面對問題來解決。|;
		  }
# ＊ 右弼加會擎羊、陀羅，感情多困擾，勇於面對問題來解決。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情多困擾，勇於面對問題來解決。|;
		  }
# ＊ 右弼加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌多感情多困擾，多變動，勇於面對問題來解決。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|多感情多波折，勇於面對問題來解決。|;
		  }
		  
# ＊ 大小限遇右弼星事業順利。
# ＊ 右弼在夫妻宮，主人定二婚。
# ＊ 右弼與諸煞同宮，羊陀火忌沖合，福薄。


		  if($self->has_stars(  stars=>["七殺","破軍","貪狼"] )){
		      push @{$res->{$k}->{"additional"} },qq|主波折。|;
		  }

	      }

		 ###########verify 文昌 : 入財宮，靠學術獲利。
		################   文昌   ####################  
		if($k eq "文昌"){
		  $res->{$k}->{"main"}.= qq|

學問智慧之星。

 容貌：眉目清秀、俊雅磊落。

性格：為人聰明、多學多能。為人優雅、卻愛粉飾。

個性特質：考試、功名、學習、顯現於外的、實質上的。

		     學富多能，有機應變之才。
		      文學(主宮)。化氣為文魁。科甲。學識。美貌。桃花。昌曲為時系星，主變動、不定。

 管科甲名聲。昌曲是臨時貴人。為人耿直略孤僻、有文藝才華、有文者風範、不會有風流現象。長相很斯文，舉止優雅有氣質，給人一種溫文儒雅的感覺。思惟細膩，思考能力強，聰明、臨場反應快，口才好、具有幽默感，文昌星比較偏重思考，故文昌坐命的你文筆佳，甚至有文思泉湧，神來之筆，有利於寫作。年輕時較辛勞，老壯順遂，正直無私。多顯象智慧文書方面。清純桃花。文昌化忌容易有生命危險。智慧之星，如見化忌，可有精神方面之疾患，或感情困擾。
      		|;
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 文昌守命，廟旺見諸吉，文章蓋世，功名顯赫，尤喜與文曲同宮。
		  if(($you->{ziwei}->{$k}->{bright} eq "廟"  || $you->{ziwei}->{$k}->{bright} eq "旺" ) && $self->has_stars(  stars=>@sixlucky )){
		      push @{$res->{$k}->{"additional"} },qq|文章蓋世，功名顯赫，尤喜與文曲同宮。|;
		  }

# ＊ 文昌守命，陷見諸凶，亦主舌辯、巧藝、本事高人。
		  if($self->has_jiahui(  stars=>@sixghosts )){
		      push @{$res->{$k}->{"additional"} },qq|亦主舌辯、巧藝、本事高人。|;
		  }
# ＊ 文昌會太陽、天梁、天同，祿存，主富貴。
		  if( $self->has_jiahui(  stars=>["太陽","天梁","天同","祿存"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|主富貴。|;
		  }

# ＊ 文昌武曲於身命，文武兼備。
		  if($self->has_stars(  stars=>["武曲"] )){
		      push @{$res->{$k}->{"additional"} },qq|文武兼備。|;
		  }

# ＊ 文昌與廉貞、七殺、羊陀同宮，主詐偽。
		  if( $self->has_stars(  stars=>["廉貞","七殺","火星","鈴星"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|主詐偽。|;
		  }
# ＊ 文昌貪狼同宮，政事顛倒。
		  if($self->has_stars(  stars=>["貪狼"] )){
		      push @{$res->{$k}->{"additional"} },qq|政事顛倒。|;
		  }
# ＊ 文昌貪狼於巳亥守命，加煞化忌，主粉骨碎屍，夭亡。
		  if($self->has_stars(  stars=>["貪狼"] ) && $self->has_jiahui(  stars=>@sixghosts ) && 	$self->born(  time=>["巳","亥"] )  && $self->has_huaji( star=>$k, stars=>[ "忌"] ) ){
			    push @{$res->{$k}->{"additional"} },qq|      主粉骨碎屍，夭亡。|;

		  }
# ＊ 文昌巨門同宮，喪志。
		  if($self->has_stars(  stars=>["巨門"] )){
		      push @{$res->{$k}->{"additional"} },qq|喪志。|;
		  }
# ＊ 文昌破軍同宮，主有水災。
		  if($self->has_stars(  stars=>["破軍"] )){
		      push @{$res->{$k}->{"additional"} },qq|主有水災。|;
		  }
# ＊ 文昌代表文學。
		      push @{$res->{$k}->{"additional"} },qq|文學。|;
# ＊ 文昌為南斗星為人多文質彬彬，思想敏銳。
		      push @{$res->{$k}->{"additional"} },qq|人多文質彬彬，思想敏銳。|;
# ＊ 文昌加會左輔、右弼，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
# ＊ 文昌加會文曲，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
# ＊ 文昌加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 文昌化科：有才華。
		  if($self->has_huaji( star=>$k, stars=>[ "科"] )){
		       push @{$res->{$k}->{"additional"} },qq|有才華。|;
		  }
# ＊ 文昌化忌：專研某事物或無法專心。
		  if($self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|專研某事物或無法專心。|;
		  }
# ＊ 文昌加會科、權、祿，得文財，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得文財，企業管理人才。|;
		  }
# ＊ 文昌加會火星或鈴星錢財不聚，有小聰明，有巧藝。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，有小聰明，有巧藝。|;
		  }
# ＊ 文昌加會擎羊、陀羅，錢財不聚，有巧藝。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，有巧藝。|;
		  }
# ＊ 文昌加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌多精神不佳，有巧藝。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|多精神不佳，有巧藝。|;
		  }
		  
# ＊ 大小限遇文昌星宜學習新事物。
# ＊ 文昌喜金生人，富貴雙全，先難後易，中晚有聲名。
# ＊ 文昌左輔，位至三台。
# ＊ 文科拱照，賈誼年少登科。（論三方）
# ＊ 文昌陷於天傷，顏回夭折。（命有劫空羊陀，限至七殺，羊陀迭並方論）

		  if($self->has_stars(  stars=>["廉貞","七殺","陀羅","擎羊"] ) || $self->has_jiahui(  stars=>["廉貞","七殺","陀羅","擎羊"] )){
		      push @{$res->{$k}->{"additional"} },qq|虛偽不誠之人。|;
		  }


	      }

		 ###########verify 文曲 : 入財宮，靠機會獲利。
		################   文曲   ####################  
		if($k eq "文曲"){
		  $res->{$k}->{"main"}.= qq|

才藝才能之星。

 容貌：眉目清秀、俊雅磊落。

性格：為人聰明、多學多能。為人優雅、卻愛粉飾。

個性特質：技藝、名氣、創作、隱藏於內精神上無形的。

		     聰明多智，能言善辯。
文藝(主宮)。化氣為耗損。辭辯。學識。美貌。桃花。天魁、天鉞。貴人(主宮)。尊貴。桃花。小人。

  主天理、文件文書、證書、支票，管科甲名聲、文墨官場、功名、文雅風騷。主口才音樂、星相醫理、例如偏印走偏鋒較無文人風範、但亦性磊落、口舌狂。主科甲，色黃。口才與精神思想很靈感，感情，金錢。與文昌星非常類似的性質，都是學習星，但文昌星偏於正統學習，而文曲星則偏於才藝、口才與精神思想方面。帶桃花性，容易留下後遺症。文曲化忌容易有婚姻問題。智慧之星，如見化忌，可有精神方面之疾患，或感情困擾。

      		|;
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      

# ＊ 文曲代表柔和、口才。
			   push @{$res->{$k}->{"additional"} },qq|代表柔和、口才。|;
# ＊ 文曲加會左輔、右弼，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，有巧藝。|;
		  }
# ＊ 文曲加會文昌，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文昌"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
# ＊ 文曲加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 文曲化科：有才華，口才佳。
		  if($self->has_huaji( star=>$k, stars=>[ "科"] )){
		       push @{$res->{$k}->{"additional"} },qq|有才華，口才佳。|;
		  }
# ＊ 文曲化忌：專研某事物或無法專心，口才差。
		  if($self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|：專研某事物或無法專心，口才差。|;
		  }
# ＊ 文曲加會科、權、祿，得文財，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得文財，企業管理人才。|;
		  }
# ＊ 文曲加會火星或鈴星錢財不聚，感情不順。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情不順。|;
		  }
# ＊ 文曲加會擎羊、陀羅，錢財不聚，有名無實。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，有名無實。|;
		  }
# ＊ 文曲加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌多感情不佳。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|多感情不佳。|;
		  }
# ＊ 大小限遇文曲星宜學習新事物。

		}

		################   天魁   ####################  
		if($k eq "天魁"){
		  $res->{$k}->{"main"}.= qq|
天降貴人。

 容貌：具足威儀。

性格：有威有畏、友儀可象。

個性特質：男性貴人、實質上的幫助、開發創造。

		 儀表秀雅，文章秀士，得貴人相助。高貴典雅，自助而後得人相助。

 主科名、陽貴人、長輩貴人幫助很明顯，有形實質助力。於人主心地善良、較威嚴、分析能力強、設想週到、說話有分量。主高貴功名風雅、心直口快、說一不二、說真話會得罪人、不會隱瞞、喜管閒事、棘手時會逃避是為主象。比較不服輸，很自然就給人高傲的感覺，不會輕易服人，領悟力強，悟性高。利於科舉。有逢凶化吉，消災解厄之作用。惹禍桃花，外遇對象一般較年長。好之助力（明助），代表男性（機遇）。你會具超感應能力，對靈異的現象感應特別強，特別敏感，你的思想超然，但會給人曲高和寡的感覺。五十歲以後變小人，易有煩擾阻礙或顯示缺點等。

      		|;
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 天魁代表正直，善良。
			   push @{$res->{$k}->{"additional"} },qq|代表正直，善良。|;
# ＊ 天魁為南斗助星為人積極，機敏。
			   push @{$res->{$k}->{"additional"} },qq|代表正直，善良。|;
# ＊ 天魁加會左輔，右弼有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }

# ＊ 天魁加會文昌，文曲，感情豐富，有才采。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才采。|;
		  }
# ＊ 天魁加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 天魁加會火星或鈴星錢財不聚，感情多困擾。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情多困擾。|;
		  }
# ＊ 天魁加會擎羊、陀羅，錢財不聚，感情多困擾。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情多困擾。|;
		  }
# ＊ 天魁加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌，錢財不聚，感情多困擾。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情多困擾。|;
		  }
# ＊ 大小限遇天魁星機運佳。

	      }

		################   天鉞   ####################  
		if($k eq "天鉞"){
		  $res->{$k}->{"main"}.= qq|

愛的貴人。

 容貌：具足威儀。

性格：有威有畏、友儀可象。

個性特質：女性貴人、精神上的幫助、守成保守。

		 帶桃花性質，有貴人扶助。高貴典雅，自助而後得人相助。

管科名、夜生人有貴氣，乃玉堂貴人。是一顆〝權力星〞、〝權威星〞、〝傷害星〞、〝刑傷星〞。權力慾望很強，行事果斷，強硬剛毅 ，有傲氣，非常強勢的人，要求嚴格，有時給人刻薄之印象。男性天鉞坐命會有點女性化，女命則氣質高雅人見人愛，易受感動而被追到手。有逢凶化吉，消災解厄之作用。惹禍桃花，外遇對象一般較年長。好之助力（暗助），代表女性（機遇）。非常適合進公家機關做事。五十歲後是煩擾阻礙。
      		|;
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 天鉞代表自重，好義。 
			   push @{$res->{$k}->{"additional"} },qq|代表自重，好義。 |;
# ＊ 天鉞為南斗助星為人積極，上進。
			   push @{$res->{$k}->{"additional"} },qq|為人積極，上進。|;
# ＊ 天鉞加會左輔，右弼有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }

# ＊ 天鉞加會文昌，文曲，感情豐富，有才采。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才采。|;
		  }
# ＊ 天鉞加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 天鉞加會火星或鈴星錢財不聚，感情多困擾。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情多困擾。|;
		  }
# ＊ 天鉞加會擎羊、陀羅，錢財不聚，感情多困擾。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情多困擾。|;
		  }
# ＊ 天鉞加會火星、鈴星、擎羊、陀羅、地空、地劫、化忌，錢財不聚，感情多困擾。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情多困擾。|;
		  }
# ＊ 大小限遇天鉞星機運佳。

	      }


		 ###########verify 
		################   火星   ####################  入財宮或夾財富，除火貪、鈴貪外，並不主進財。
		if($k eq "火星"){
		  $res->{$k}->{"main"}.= qq|

		  火爆浪子。

		容貌：毛髮生異、吞炭裝啞。

		性格：好大喜功、求快棄安。雖為快速、稍嫌粗野。

		個性特質：爆發、殺氣、火災、獨特。

		 性剛強出眾，有突發表現，辛勤難免。暴躁(主宮)。傷害。

		          主剛，丹田有力，說話宏亮遇事急燥，脾氣暴躁，任事有獨特表現，處事欠考慮，個性衝動比較沉不注氣，有時難免信口開河，容易傷感情。最宜貪狼。艷麗，明亮耀眼，野性美。易犯尖煞、燒傷。摧化劑，急劇變化，怕見化忌星（但可剋制擎羊之劫財）。具有強烈的毀滅性。男生火星在命宮---你的相貌堂堂而且氣宇非凡。女生火星在命宮---妳有沉魚落雁，閉月羞花之貌喔，貞潔烈婦，事業有表現。

      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 火星代表有膽識。
			   push @{$res->{$k}->{"additional"} },qq|有膽識。|;
# ＊ 火星為南斗浮星為人外向，不耐靜。
			   push @{$res->{$k}->{"additional"} },qq|為人外向，不耐靜。|;
# ＊ 火星加會左輔、右弼，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
# ＊ 火星加會文曲，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
# ＊ 火星加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 火星加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 火星加會擎羊、陀羅，是非多，權威出眾。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|是非多，權威出眾。|;
		  }
# ＊ 火星加會鈴星、擎羊、陀羅、地空、地劫、化忌是非多。
		  if($self->has_jiahui(  stars=>[ "鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|是非多。|;
		  }
# ＊ 大小限遇火星精神壓力大。

	      }
# 
		 ###########verify 
		################   鈴星   ####################  入財宮或夾財富，除火貪、鈴貪外，並不主進財。
		if($k eq "鈴星"){
		  $res->{$k}->{"main"}.= qq|

		冷靜沈默的殺手。

 容貌：毛髮生異、吞炭裝啞。

性格：好大喜功、求快棄安。雖為快速、稍嫌粗野。

個性特質：虛躁、侵略、衝動。

		 性情凶暴，膽大出眾。暴躁(主宮)。傷害。

為號令之星，與聲名、名譽有關。形貌異常，性格陰沈，性烈嫉妒，膽大出眾，內向不說話。艷麗，明亮耀眼，野性美。容易有肢體刑傷。摧化劑，急劇變化，怕見化忌星。反應快，有急智，處事果斷必有表現，好大喜功，愛表現，心較窄小，故橫成又橫破，好命之時空亦心神不寧多災難，所以性格獨特。具有音樂才華。


      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }


# ＊ 鈴星代表果斷。
			   push @{$res->{$k}->{"additional"} },qq|果斷。|;
# ＊ 鈴星為南斗浮星為人性急，不耐靜，愛表現。
			   push @{$res->{$k}->{"additional"} },qq|為人性急，不耐靜，愛表現。|;
# ＊ 鈴星加會左輔、右弼，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
# ＊ 鈴星加會文曲，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
# ＊ 鈴星加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 鈴星加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 鈴星加會擎羊、陀羅，親緣薄。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|親緣薄。|;
		  }
# ＊ 鈴星加會火星、擎羊、陀羅、地空、地劫、化忌親緣薄。
		  if($self->has_jiahui(  stars=>[ "火星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|親緣薄。|;
		  }
# ＊ 大小限遇鈴星精神壓力大。
	      }

		 ###########verify 
		################   擎羊   ####################  陀羅為隱藏式破財。羊刃為直接式破財。羊陀夾財宮，進財風險大，長痛不如短痛。
		if($k eq "擎羊"){
		  $res->{$k}->{"main"}.= qq|
又稱羊刃，帶刃帶殺的血光客。

 容貌：形貌醜陋、體態嬌詐。

性格：剛強果決、機謀嬌詐。為人勇敢、卻也殘忍。

個性特質：殺傷力、刀光血災、官司訴訟、急躁不安。

主災煞，是一顆傷害星。血光，是非，開刀，性好強，激烈，不認輸，易有報復之心，宜修心養性。主具衝動，遇事容易心浮沉不住氣，從正面來看、表示你做事很積極、有先見之明、具有前瞻性。於人命身，多主有刑傷、骨折，身體必然留有傷疤記號。擎羊沉不住氣。適合在軍警界、黑白兩道、律師方面發展。權力，爭，開刀，破相，意外，財破，但後果很快完結（被動）。利西北生人，以辰戍丑未年支生人立命於四墓地為福，居子午卯酉刑剋極重，子午宮吉多可解。

		 性剛果決，主刑傷，好比明槍。傷害(主宮)。是非。桃花。感情。武勇。

      		|;
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
		  
#  ＊ 擎羊代表權威，果決。
			   push @{$res->{$k}->{"additional"} },qq|權威，果決。|;
# ＊ 擎羊為北斗助星為人事業心強，頗有個性。
			   push @{$res->{$k}->{"additional"} },qq|為人事業心強，頗有個性。|;
# ＊ 擎羊加會左輔、右弼，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
# ＊ 擎羊加會文昌、文曲，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
# ＊ 擎羊加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 擎羊加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 擎羊加會火星或鈴星主有權威。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|主有權威。|;
		  }
# ＊ 擎羊加會火星、鈴星、地空、地劫、化忌主破財，衝動。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|主破財，衝動。|;
		  }
# ＊ 大小限遇擎羊星事業有阻，健康不利。
	      }
		 ###########verify 
		################   陀羅   ####################  陀羅為隱藏式破財。羊刃為直接式破財。羊陀夾財宮，進財風險大，長痛不如短痛。
		if($k eq "陀羅"){
		  $res->{$k}->{"main"}.= qq|

		  亂轉一通、心無頭緒的陀螺。

 容貌：形貌醜陋、體態嬌詐。

性格：剛強果決、機謀嬌詐。為人勇敢、卻也殘忍。

個性特質：遲疑阻礙、三心二意、不穩定、鑽牛角尖、爆烈。

忌星，性蹉跎，撈叨。主勇敢而殘忍。陀羅有〝拖延〞、〝延後〞、〝打轉〞之意，動作較慢、做事較不乾脆、喜歡拖泥帶水；亦有〝諸事晚成〞之意。 於人命身，思想上會顯得比較頑固，與六親寡和，有代溝現象。謀事不順多阻礙，煩惱較多。於人命身疾厄，容易有隱性疾病或神經風濕之疾。 陀羅缺臨門一腳。適合在軍警界、黑白兩道、律師方面發展。急劇成敗，但影響深遠（爭取失敗）。單守身命，主孤單容易離鄉背景，尤忌久居出生地，出外不妨。

		 對命運予以挫折，威力不顯於外，好比暗箭。傷害(主宮)。是非。桃花。感情。武勇。

      		|;
		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
		  
# ＊ 陀羅代表不乾脆，威猛，機智，推理。
			   push @{$res->{$k}->{"additional"} },qq|不乾脆，威猛，機智，推理。|;
# ＊ 陀羅為北斗助星為人頑固，但容忍心強。
			   push @{$res->{$k}->{"additional"} },qq|為人頑固，但容忍心強。|;
# ＊ 陀羅加會左輔、右弼，有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
# ＊ 陀羅加會文曲，感情豐富，有才藝。
		  if( $self->has_jiahui(  stars=>["文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
# ＊ 陀羅加會天魁、天鉞，機運多。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。|;
		  }
# ＊ 陀羅加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 陀羅加會火星或鈴星主破財，易受騙。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|主破財，易受騙。|;
		  }
# ＊ 陀羅加會火星、鈴星、地空、地劫、化忌主破財，易受騙。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|主破財，衝動。|;
		  }
# ＊ 大小限遇陀羅星利於探討人生，事業宜守。

	      }


		################   天空   ####################  
		if($k eq "天空"){
		  $res->{$k}->{"main"}.= qq|
		  空忙一場的努力。

		 做事虛發，成敗多端，不聚財，精神多空虛。落空(主宮)。玄學。破財。墜傷。刑傷。
 容貌：鼻仰而露。

性格：浪費不節儉。

個性特質：思想偏激、天馬行空、墜樓、僧道方外之人。

		   第一劫星，主虛耗破敗，波動大多是負面的，此星不利經商宜買空賣空。空亡之星，多災，劫出，較不利財（先有後無之象）。 主精神。於人命身，主人多點子，喜歡胡思亂想(幻想)，精神多空虛煩惱。天空坐命如半天折翅。 六親緣薄。與宗教有緣。感情上破秏。創思力高。
      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 天空代表不畏挫折，揮霍，靈感佳。
			   push @{$res->{$k}->{"additional"} },qq|不畏挫折，揮霍，靈感佳。|;
# ＊ 天空加會左輔，右弼有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
# ＊ 天空加會文昌，文曲，感情豐富，有才采。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝。|;
		  }
# ＊ 天空加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 天空加會火星或鈴星敢賺敢花，買空賣空。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|敢賺敢花，買空賣空。|;
		  }
# ＊ 天空加會擎羊、陀羅，敢賺敢花，買空賣空。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|敢賺敢花，買空賣空。|;
		  }
# ＊ 天空加會火星、鈴星、擎羊、陀羅、地劫、化忌，敢賺敢花，可為科學家，詩人。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|敢賺敢花，可為科學家，詩人。|;
		  }
# ＊天空象徵靈感。 
		       push @{$res->{$k}->{"additional"} },qq|象徵靈感。|;
# ＊天空易有天竺生涯，為人較有孤獨性。 
		       push @{$res->{$k}->{"additional"} },qq|有天竺生涯，為人較有孤獨性。 |;
# ＊天空加會左輔、右弼，領悟力強，受人重視。 
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|領悟力強，受人重視。 |;
		  }
# ＊天空加會文昌、文曲，有宗教信仰，喜研究玄學，神密學。 
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有宗教信仰，喜研究玄學，神密學。 |;
		  }
# ＊天空加會天魁、天鉞，機敏，受人欣賞。 
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機敏，受人欣賞。 |;
		  }
# ＊天空加會祿、權，科，智慧一流，人緣佳，凡事順利。 
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|智慧一流，人緣佳，凡事順利。 |;
		  }
# ＊天空加會火星或鈴星，逢凶化吉。 
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|逢凶化吉。 |;
		  }
# ＊天空加會擎羊、陀羅，逢凶化吉。 
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|逢凶化吉。|;
		  }
# ＊天空加會火星、鈴星、擎羊、陀羅、地空、地劫，逢凶化吉。 
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"])  ){
		       push @{$res->{$k}->{"additional"} },qq|逢凶化吉。 |;
		  }
# ＊大小限遇天空宜研究學術。
# ＊ 大小限遇天空星破財運，宜參研宗教，學術。

		}

		################   地劫   ####################  
		if($k eq "地劫"){
		  $res->{$k}->{"main"}.= qq|

劫財搶錢的賊狀元。

 容貌：鼻仰而露。

性格：浪費不節儉。

個性特質：行為怪異、車禍、水難、驚嚇、破敗。

		做事疏忽，不行正道，錢財與感情皆不利，一生起伏不定，有隱疾。落空(主宮)。玄學。破財。墜傷。刑傷。

 第二劫星，主虛耗破敗，波動大多是負面的，此星不利經商宜買空賣空。空亡之星，耗損劫入，較不利於錢財、感情（先無後有之象）。頭腦聰明，反應靈敏，身材瘦小，個性獨特，性格多變，個性強。主物質，即財物耗失較大。地劫坐命如浪裡行船。六親緣薄。與宗教有緣。物質上破秏。感覺自己沒有什麼份量，不受到別人的重視，自己常常會有自卑的感覺，覺得自己不如別人，比較容易鬱卒，缺乏自信心。
      		|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

# ＊ 地劫代表努力不懈，獨立，靈感佳。 
			   push @{$res->{$k}->{"additional"} },qq|努力不懈，獨立，靈感佳。 |;
# ＊ 地劫加會左輔，右弼有管理能力。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力。|;
		  }
# ＊ 地劫加會文昌，文曲，感情豐富，有才采。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才采。|;
		  }
# ＊ 地劫加會科、權、祿，得財利，企業管理人才。
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊ 地劫加會火星或鈴星，敢賺敢花，買空賣空。
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|敢賺敢花，買空賣空。|;
		  }
# ＊ 地劫加會擎羊、陀羅，敢賺敢花，買空賣空。
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|敢賺敢花，買空賣空。|;
		  }
# ＊ 地劫加會火星、鈴星、擎羊、陀羅、地空、化忌，敢賺敢花，可為科學家，詩人。
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ||   $self->has_huaji( star=>$k, stars=>[ "忌"] )){
		       push @{$res->{$k}->{"additional"} },qq|敢賺敢花，可為科學家，詩人。|;
		  }
# ＊ 大小限遇地劫星破財運，宜參研宗教，學術。

	      }

		################   天刑   ####################  
		if($k eq "天刑"){
		  $res->{$k}->{"main"}.= qq|
		    是一顆傷害星、是非星、災禍星。行事會執行到底，保持原則故示多勞碌，看似不易接近實心地很好與宗教有緣。與僧道有關，為人個性剛直，對法律、命理、醫術、佛緣有特殊愛好。易犯官非訴訟。坐疾厄宮容易有開刀或是肢體刑傷的事件產生。落哪一宮，哪一宮刑剋重。自律，受控制；會見化忌或凶星，反會失控，助紂為虐。天刑坐命的你其實叛逆性很強，於人帶點孤傲主有才幹，行事會執行到底，要注意官司牢獄之災及官訟。    	

		  |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
# ＊天刑象徵才幹，自主。 
			   push @{$res->{$k}->{"additional"} },qq|才幹，自主。 |;
# ＊天刑為人較有孤獨性，不喜借助他人之力，高傲，一生多勞碌，喜歡神密學、玄學。
			   push @{$res->{$k}->{"additional"} },qq|不喜借助他人之力，高傲，一生多勞碌，喜歡神密學、玄學。|;
# ＊天刑加會左輔、右弼，熱心助人，積極果決。 
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|熱心助人，積極果決。 |;
		  }
# ＊天刑加會文昌、文曲，易有權位，學問佳。 
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|易有權位，學問佳。 |;
		  }
# ＊天刑加會天魁、天鉞，機運多，地位易提升。 
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多，地位易提升。 |;
		  }
# ＊天刑加會祿、權，科，得財，人緣佳，易有權威。 
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|得財利，企業管理人才。|;
		  }
# ＊天刑加會火星或鈴星，是非多，做事辛勞。 
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|是非多，做事辛勞。 |;
		  }
# ＊天刑加會擎羊、陀羅，是非多，做事辛勞，是非多。 
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|是非多，做事辛勞，是非多。 |;
		  }
# ＊天刑加會火星、鈴星、擎羊、陀羅、地空、地劫，做事效率不佳，易有訴訟。 
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"])){
		       push @{$res->{$k}->{"additional"} },qq|做事效率不佳，易有訴訟。 |;
		  }
# ＊大小限遇天刑加會白虎、火星、鈴星易有官司，加會吉星有威望。

	      }

		################   天姚   ####################  
		if($k eq "天姚"){
		  $res->{$k}->{"main"}.= qq|
		      主風流、為桃花、愛慕、好淫、痴情、口才好。早熟、風騷、風雅幽默、聰明、反應靈敏、人緣佳、好聊天、對藝術歌舞有特殊之天份、玩世不恭、好飲、遊戲人間、喜交際。情感豐富，情慾重。招手成親。風情萬種，不拘小節；如見化忌星，發姣。女生而天姚星在命宮表示你的談吐、容貌花俏動人，騷勁十足，喜歡打扮並且搔首弄姿，只是在外面總是愛的不追，追的不愛。 男生而天姚星在命宮表示你為獵豔高手，是個花心大蘿蔔，喜歡到處拈花惹草，玩世不恭。
		  |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
# ＊天姚象徵交際。 
			   push @{$res->{$k}->{"additional"} },qq|象徵交際。|;
# ＊天姚為人多縱情，反應快，人緣佳。 
			   push @{$res->{$k}->{"additional"} },qq|為人多縱情，反應快，人緣佳。 |;
# ＊天姚加會左輔、右弼，有管理能力，有魅力。 
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力，有魅力。 |;
		  }
# ＊天姚加會文昌、文曲，感情豐富，有才藝，有情趣。
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|感情豐富，有才藝，有情趣。|;
		  }
# ＊天姚加會天魁、天鉞，機運多。 
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|機運多。 |;
		  }
# ＊天姚加會祿、權，科，得財，有管理能力，受人肯定。 
		  if(  $self->has_jiahui_huaji( star=>$k, stars=>[ "權","祿","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|有管理能力，受人肯定。 |;
		  }
# ＊天姚加會火星或鈴星錢財不聚，感情多波折。 
		  if( $self->has_jiahui(  stars=>["火星"]) || $self->has_jiahui(  stars=>["鈴星"]) ) {
			   push @{$res->{$k}->{"additional"} },qq|錢財不聚，感情多波折。 |;
		  }
# ＊天姚加會擎羊、陀羅，穩定性弱，感情多波折。 
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|穩定性弱，感情多波折。 |;
		  }
# ＊天姚加會火星、鈴星、擎羊、陀羅、地空、地劫感情多波折。 
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"])){
		       push @{$res->{$k}->{"additional"} },qq|感情多波折。 |;
		  }
# ＊大小限遇天姚，桃花運。
	      }


		################   天哭   ####################  
		if($k eq "天哭"){
		  $res->{$k}->{"main"}.= qq|
		          天哭、憂傷、傷心、哭喪。於人個性有點孤僻，喜歡庸人自擾之，示會較勞碌，如果主星吉反而容易出名，加煞星多則恐有破敗，或會到天虛則有傷心或喪事等。助巨門之凶。感情上打擾，損秏。如果主星不好（如巨門、太陰）就是標準的苦瓜臉，哭喪臉。
		  |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
# ＊天哭象徵消極。 
			   push @{$res->{$k}->{"additional"} },qq|消極。|;
		  
# ＊天哭為人輕財重義，做事有原則。
			   push @{$res->{$k}->{"additional"} },qq|輕財重義，做事有原則。|;
		  
# ＊天哭加會左輔、右弼，勤勞節儉。 
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|勤勞節儉。 |;
		  }
		  
# ＊天哭加會文昌、文曲，有文采。 
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有文采。|;
		  }
# ＊天哭加會天魁、天鉞，有親和力，易結交有力人士。 
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有親和力，易結交有力人士。|;
		  }
# ＊天哭加會祿、權，科，有魄力，名利雙收。 
		  if(  $self->has_huaji( star=>$k, stars=>[ "祿","權","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|有魄力，名利雙收。|;
		  }
# ＊天哭加會火星或鈴星，內心孤獨。 
		  if( $self->has_jiahui(  stars=>["火星"] ) ||  $self->has_jiahui(  stars=>["鈴星"] )  ) {
			   push @{$res->{$k}->{"additional"} },qq|內心孤獨。 |;
		  }
# ＊天哭加會擎羊、陀羅，為人消極。 
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|為人消極。 |;
		  }
# ＊天哭加會火星、鈴星、擎羊、陀羅、地空、地劫，內心孤獨，為人消極，破財。 
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ){
		       push @{$res->{$k}->{"additional"} },qq|內心孤獨，為人消極，破財。 |;
		  }
# ＊大小限遇天哭加會吉星有權威加會煞星破財，思想消極。
	      }

		################   天虛   ####################  
		if($k eq "天虛"){
		  $res->{$k}->{"main"}.= qq|
		          於人個性較好大喜功不實際，稱之華而不實也，親人少助力。又代表了〝毛病〞、〝錯誤〞、〝失敗〞、〝虛弱〞、〝生病〞。助破軍之凶，女生坐此命格更不利。物質上損秏。天虛坐命的你--表示你天生體弱多病，也容易犯錯而招致失敗。|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
# ＊天虛象徵飄浮不定。 
			   push @{$res->{$k}->{"additional"} },qq|飄浮不定。 |;
# ＊天虛為人喜清靜，安於現狀。 
			   push @{$res->{$k}->{"additional"} },qq|為人喜清靜，安於現狀。 |;
# ＊天虛加會左輔、右弼，衣食足。 
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|衣食足。 |;
		  }
		  
# ＊天虛加會文昌、文曲，有文采。 
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有文采。|;
		  }
# ＊天虛加會天魁、天鉞，有親和力，易結交有力人士。
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|有親和力，易結交有力人士。|;
		  }
# ＊天虛加會祿、權，科，有魄力，名利雙收。 
		  if(  $self->has_huaji( star=>$k, stars=>[ "祿","權","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|有魄力，名利雙收。 |;
		  }
# ＊天虛加會火星或鈴星，較無主見。 
		  if( $self->has_jiahui(  stars=>["火星"] ) ||  $self->has_jiahui(  stars=>["鈴星"] )  ) {
			   push @{$res->{$k}->{"additional"} },qq|較無主見。 |;
		  }
# ＊天虛加會擎羊、陀羅，為人華而不實。 
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|為人華而不實。 |;
		  }
# ＊天虛加會火星、鈴星、擎羊、陀羅、地空、地劫，較無主見，為人華而不實，破財。 
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ){
		       push @{$res->{$k}->{"additional"} },qq|較無主見，為人華而不實，破財。 |;
		  }
# ＊大小限遇天虛加會吉星生活安樂加會煞星破財消災。

	      }
		################   紅鸞   ####################  
		if($k eq "紅鸞"){
		  $res->{$k}->{"main"}.= qq|
		          	主婚聚喜慶、流蕩、虛榮、直爽、多變動、易與人接近，在命為虛榮心重。早年逢之婚喜、中年逢之添丁桃花慶團聚、老年逢之喪妻跌交苦、會桃花星多淫慾，會大耗破財不免，會殺羊豈不刀帶血。追情逐愛（開始）。長相不錯，人緣很好。 個性直爽、具有親和力、而且你非常有異性緣、早婚的機率高，不適宜再遇上其他的桃花星，否則你的感情生活將會比較複雜。|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################   天喜   ####################  
		if($k eq "天喜"){
		  $res->{$k}->{"main"}.= qq|
		          	主婚聚喜慶、熱鬧、衝動、與人有禒亦帶孤、隨遇而安、喜交遊多外出，異性緣佳。早年得長輩之喜愛，中年多交友，老逢多孤易接近少年人。入命訂婚早未必早結婚，殺煞會命開刀。成其婚事（結果）。一生容易逢凶化吉，而且笑口常開，喜歡熱鬧，愛表現，活動力強，你會講黃色笑話，而且也會去聽。 |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################   孤辰   ####################  
		if($k eq "孤辰"){
		  $res->{$k}->{"main"}.= qq|
		          	個性有點固執孤僻心理想法不是很健全，所以不宜入於父母宮容易造成親人緣薄遲婚或聚少離多等等。孤、寡有很強勢的意思，在人群之中為佼佼者，有〝獨占鰲頭〞之意。自我意識非常強，主觀意識也很強，你比較孤傲，即使你沒有這個意思，默默的坐在一旁都會表現出很強的孤傲氣，所以你常常覺得孤單，會有高處不勝寒的感覺，你不喜歡被約束，在工作領域中會是一位佼佼者。 |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################   寡宿   ####################  
		if($k eq "寡宿"){
		  $res->{$k}->{"main"}.= qq|
		          	個性有點孤獨不近人情容易自以為是，故親緣薄弱，不宜坐命宮、福德宮或夫妻宮，主自視高外表有傲氣其實內心滿脆弱的。孤、寡有很強勢的意思，在人群之中為佼佼者，有〝獨占鰲頭〞之意。自我意識非常強，主觀意識也很強，你比較孤傲，即使你沒有這個意思，默默的坐在一旁都會表現出很強的孤傲氣，所以你常常覺得孤單，會有高處不勝寒的感覺，你不喜歡被約束，在工作領域中會是一位佼佼者。 |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################   破碎   ####################  
		if($k eq "破碎"){
		  $res->{$k}->{"main"}.= qq|
		          凡事反覆容易坐立不安，做事將成又生風波致破，主少成多敗。入命者或行運走到，做事常常功敗垂成，常常只差臨門一腳，事情無法稱心如意。有時會有消極或毀滅的思想，生氣時會摔東西，砸東西，損壞物品。會有〝寧為玉碎、不為瓦全〞的觀念。|;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }


		################   陰煞   ####################  
		if($k eq "陰煞"){
		  $res->{$k}->{"main"}.= qq|
		          指〝暗計〞、〝小人〞。具邪祟之氣，有〝暗藏、晦暗不明、潛伏、骯髒〞之意。 忌入命身、田宅。 落疾厄宮容易有業障疾病，如癌症、精神異常、附靈等等。落哪一宮，哪一宮容易出事。靈覺高。比較容易會鬱鬱寡歡，個性是非常的不服輸，而且敏感、多疑、好忌妒。比較容易察覺到別人的心思及計謀。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }
# ＊陰煞象徵小人，疑心。 
			   push @{$res->{$k}->{"additional"} },qq|象徵小人，疑心。 |;
# ＊陰煞為人易自我反省約束。 
			   push @{$res->{$k}->{"additional"} },qq|為人易自我反省約束。 |;
# ＊陰煞加會左輔、右弼，積極奮發。
		  if( $self->has_jiahui(  stars=>["左輔","右弼"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|積極奮發。|;
		  }
# ＊陰煞加會文昌、文曲，記取教訓。 
		  if( $self->has_jiahui(  stars=>["文昌","文曲"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|記取教訓。 |;
		  }
# ＊陰煞加會天魁、天鉞，易結交有三教九流之士。 
		  if( $self->has_jiahui(  stars=>["天魁","天鉞"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|易結交有三教九流之士。 |;
		  }
# ＊陰煞加會祿、權，科，名利雙收。 
		  if(  $self->has_huaji( star=>$k, stars=>[ "祿","權","科"] ) ) {
			   push @{$res->{$k}->{"additional"} },qq|有魄力，名利雙收。 |;
		  }
# ＊陰煞加會火星或鈴星，易精神不振。 
		  if( $self->has_jiahui(  stars=>["火星"] ) ||  $self->has_jiahui(  stars=>["鈴星"] )  ) {
			   push @{$res->{$k}->{"additional"} },qq|易精神不振。 |;
		  }
# ＊陰煞加會擎羊、陀羅，不滿現狀。 
		  if( $self->has_jiahui(  stars=>["擎羊","陀羅"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|不滿現狀。 |;
		  }
# ＊陰煞加會火星、鈴星、擎羊、陀羅、地空、地劫，易精神不振，易疑神疑鬼。 
		  if($self->has_jiahui(  stars=>[ "火星","鈴星","擎羊","陀羅","地空","地劫"]) ){
		       push @{$res->{$k}->{"additional"} },qq|易精神不振，易疑神疑鬼。 |;
		  }
# ＊大小限遇陰煞受人拖累或事事受阻。
	      }


		################  將星   ####################  
		if($k eq "將星"){
		  $res->{$k}->{"main"}.= qq|
		      主化凶為吉。	入命身宮主武貴。衝勁。

		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  攀鞍   ####################  
		if($k eq "攀鞍"){
		  $res->{$k}->{"main"}.= qq|
		      主功名。
            入命身宮主武顯。科名，利於考試。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  歲馹   ####################  
		if($k eq "歲馹"){
		  $res->{$k}->{"main"}.= qq|
		      天馬。 主遷移、變動、遠行或較忙碌時期。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  息神   ####################  
		if($k eq "息神"){
		  $res->{$k}->{"main"}.= qq|
		      主消沉。  入命身宮若無吉化解主人無生氣。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  華蓋   ####################  
		if($k eq "華蓋"){
		  $res->{$k}->{"main"}.= qq|
		      陽木。主孤高。科名、文章、威儀、儀表、宗教。  入命身宮宜僧道不宜凡俗。外表美麗，但無實質。 相貌威嚴，性格孤獨而有宗教信仰，高傲不群，喜助弱者，且直言不忌。

		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  劫煞   ####################  
		if($k eq "劫煞"){
		  $res->{$k}->{"main"}.= qq|
		    主盜。  喜諸吉化解。忌諸凶。中途阻滯。 工作不如意。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  災煞   ####################  
		if($k eq "災煞"){
		  $res->{$k}->{"main"}.= qq|
		    主災患。  喜諸吉化解。忌諸凶。外來之災，防別人詐騙。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  天煞   ####################  
		if($k eq "天煞"){
		  $res->{$k}->{"main"}.= qq|
		    主剋夫剋父。  忌入命身父母夫妻宮。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

		}

		################  指背   ####################  
		if($k eq "指背"){
		  $res->{$k}->{"main"}.= qq|
		    主誹謗。  忌入命身宮。背後小人造謠中傷或是誹謗。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }


		################  咸池   ####################  
		if($k eq "咸池"){
		  $res->{$k}->{"main"}.= qq|
		    主桃花。 性格浮蕩虛花，好色淫慾，孤剋，多疾病，為人好酒與賭博。防感情糾紛或不順。
                入命身福德諸宮主好色。男歡女愛中，懂得享受魚水之歡（在命宮，福德宮）。
		    |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  月煞   ####################  
		if($k eq "月煞"){
		  $res->{$k}->{"main"}.= qq|
		    主剋母剋妻。  忌入命身父母夫妻宮。		  
		  |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }

		################  亡神   ####################  
		if($k eq "亡神"){
		  $res->{$k}->{"main"}.= qq|
		    主耗敗。    官非。自己失去主張，有做沒有結果，或錢財損失，記憶力較差。		  
		  |;

		  ########special
		  if( $self->has_jiagong(  stars=>["太陽","太陰"])  ) {
			   push @{$res->{$k}->{"additional"} },qq|日月左右合為佳。|;
		  }

	      }



###18zw.com
# 三台、八座星 
# 　　三台八座均为紫微的辅佐，主有权贵，主官印。入命或三方会照可增加社会地位，职掌清贵权势的组织管理，主管文章进升职位等事。紫微守命得二星同守最美，夹拱亦吉，社会地位很不错，主名贵，但不一定富有；其它吉星守命，得二星同守或夹亦吉。三台性柔细致，八座则性善勇猛。
# 　　三台八座本身并无显著的力量，喜与六吉星及甲级星，尤其紫阳阴等同宫最吉。不喜单星入夫妻宫，再会煞则助纣为虐，但没有左右二星凶，逢天相可解。
# 　　二星喜合不喜分，同守身命，主所处的社会地位会提高，三方四正会照亦不错。一星单守，即使有富贵，亦主早年离家发展，在外不得人缘，会被别人孤立。若一星单守命宫，另一星守夫妻宫，夫妇将会分离一段时间，二星同守则吉。入身命，早年离家在外，出国的机会较多。一般而言，二星入身命，吉者为有车阶级，尤其与日月会更验，三台车小，八座车大。
# 二星与天相、天同同宫，不管分与合，均主吉利，若入夫妻宫婚姻较顺，不会有离婚之苦。　　
# 三台是太阳的部下，八座是太阴的部下，二星会日月可增日月之光辉，即使日月处落陷时仍不算失辉。
# 　　☆三台星－－属阳土，代表人的职位、地位及就职部门的类别和方位。
# 　　为命宫主星时，面黄白色，圆长脸，中矮身材，面带威严。性严肃，耿直无私，心直口快，干脆利落，光明磊落，做事喜亲自动手，不随便委托他人，有仁义之心，好交友，且朋友都不错，人缘好，心地善良，好动，不耐静，性急多疑，讲排场，喜怒哀乐藏于心里，不露于形色。具有排兵布阵的能力，有谋略胆识，有一定的组织能力和社会地位。
# 　　入命，是天命有职有权有地位的人；居子午卯酉宫，具有在家族、党派、门派中的地位和职权；居寅亥申己宫为经营、军界、江湖中的地位和职权；居辰戍丑未宫，在企业部门、公署、科室、乡村中会有一定的位置。命宫好坏情况，显示其地位类别、高低，及就职部门的类别。
# 　　三台居六亲宫位，是六亲的地位及职权之所在。
# 　　入身，身居重要位置及受他人之托，代办领导的一些政务。
# 　　☆八座星－－属阴土，是权力职务的品位级别之星。
# 　　为命宫主星时，面黄白色，方长脸，中矮身材。性温和，仁慈善良，喜助人，直爽干脆，性急但做事稳妥，喜怒哀乐不形于色；为人比较懒散，喜欢享受玩乐。具有一定的领导组织能力和社会地位。
# 　　八座与身命相合，表示人的职位级别。职位级别与所入宫的地支序数相对应，如子1，丑2，寅3等等。（仍须看主星得力与否）。
# 　　入命，其人出生起就命带八品级，是有官贵之人，所在宫位即是人一生中应有的品位。（仍要主星庙旺得数才论）。对宗教信仰较虔诚。入身，做工作时，总会有一定的领导职位或职称。
# 　　入六亲宫，即表明六亲应有的品位。
# 

####www.lnka.tw
# 三臺星，五行屬戊土，陽土，主貴。主北斗之權，掌清貴之宿，專主文章做官，吉慶之事。守于身命，嚴厲艮耿直，心直口快，光明磊落。三臺可輔佐紫微，主有權勢，喜同宮入命或分守命身宮，得諸吉守照，則主貴顯可期。得三臺守命，雖可主貴，但多早年離家，出外發跡。三臺入夫妻宮，主夫婦分離，不吉，三臺與八座同守夫妻宮則白首偕老。二星合守遷移宮，每得貴人之助，平步青云，單守則獨力營求。 
#  
# 三臺之性格，為耿直無私，有威儀，逢吉加吉祥。三臺星若逢日月同度，對照，及三合，可增日月之光輝，十二宮中無失陷。
# 
# 三臺于疾厄宮，多主胃脾之疾。
# 三臺于田宅宮，主富足，近有三列成行之房屋，及牌樓，或八字形之建筑等，以吉論。（三臺星專主交通工具）。 
# 三臺加會左輔、右弼，處世明快。
# 三臺加會文昌、文曲，心胸平和。
# 三臺加會天魁、天鉞，人緣佳，易結交有力人士。
# 三臺加會祿、權，科，求名求利，易有不錯社會地位。
# 三臺加會火星或鈴星，較好動。
# 三臺加會擎羊、陀羅，性急多疑。
# 三臺加會火星、鈴星、擎羊、陀羅、地空、地劫，較好動，性急多疑。
# 大小限遇三臺加會吉星生活安樂加會煞星，理想過高。
# 三臺入夫妻宮主配偶較重名利，物質欲望高。
#  

# 八座星，己土，陰土，主科甲。為太陰之部從，喜會日月，主增輝；加會吉星，主貴。大限、流年逢之，主出外遠行，為一動星是也。
# 
# 八座星和三臺星一樣，都喜會日月，但最大的不同是：八座為「太陰」的部從，所以，表現于外的最大特色即為「明朗潔凈」，加上縝密的心思，所以可調節人生和諧歡樂，致使努力向上。
# 
# 八座加會左輔、右弼，能力佳。
# 八座加會文昌、文曲，學習力強。
# 八座加會天魁、天鉞，為人和諧，易結交有力人士。
# 八座加會祿、權，科，求名求利，易有不錯社會地位。
# 八座加會火星或鈴星，較無遠見。
# 八座加會擎羊、陀羅，領導力弱，喜愛玩樂。
# 八座加會火星、鈴星、擎羊、陀羅、地空、地劫，較無遠見，領導力弱，喜愛 　玩樂。
# 大小限遇八座加會吉星多旅游機會。
# 優點：思緒周全且感慨敏銳，樂觀豁達又處事穩健，心地慈和、正直善良，多學多能、勤于新知。
# 
# 缺點：缺乏遠見而進步有限，進取心不足每每只三分鐘熱度，優柔寡斷使領導力差，心神不定偶會前后矛盾。


	}

      }
  return $res;
}

1;

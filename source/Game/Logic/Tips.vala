using Gee;

public class Tips
{ 
  
  //bools and ints
  
   //Is there a possibility to make this hand? (Not including luck-based yakus)
       //1 yaku hands
    private bool pos_tanyao=true;
    private bool pos_pinfu=true;
    private bool pos_peikou=true;
    private bool pos_doujun=true;
    private bool pos_itsu=true;
    private bool pos_yakuhai=true;
    private bool pos_chanta=true;
      // 2 yaku hands
    private bool pos_toitsu=true;
    private bool pos_dokou=true;
    private bool pos_ankou=true;
    private bool pos_toitoi=true;
    private bool pos_hon_itsu=true;
    private bool pos_shou_sangen=true;
    private bool pos_hon_ron_tou=true;
    private bool pos_junchan_taiyao=true;
      //3-5 yakus
      
    private bool pos_ryan_peikou=true;
    private bool pos_chin_itsu=true;
    private bool pos_nagashi_mangan=true;
      // yakuman
      
    private  bool pos_kokushi_muso=true;
    private  bool pos_chuuren_poto=true;
    private  bool pos_suu_ankou=true;
    private  bool pos_ryuu_iisou=true;
    private  bool pos_ron_tou=true;
    private  bool pos_tsuu_iisou=true;
    private  bool pos_dai_sangen=true;
    private  bool pos_shu_suushii=true;
    //double yakuman
    
    private  bool pos_dai_suushii=true;
  
  
    //Number of each type of call
    	private int num_pon=0;   
	private int num_chii=0;
	private int num_honors=0;
	private int num_simple=0;
	private int num_term_and_simple=0; //chi only
	private int num_dragons=0;
	private int num_winds=0;
	private int num_terminals=0;    //pon only
	
	private int num_pin=0;
	private int num_man=0;
	private int num_sou=0;
	
    //Number of tiles that can be used in a posible call(in a open hand)
	private int o_num_pon=0;
	private int o_num_chii=0;
	private int o_num_honors=0;
	private int o_num_simple=0;
	private int o_num_dragons=0;
	private int o_num_winds=0;
	private int o_num_terminals=0;
	private int o_num_pin=0;
	private int o_num_man=0;
	private int o_num_sou=0;
        
    private ArrayList<Tile> tiles; 
    private ArrayList<RoundStateCall> calls;
    private Wind wp;
    private Wind wr;
    
    
      
  public static Tips(ArrayList<Tile> hand, ArrayList<RoundStateCall>? calls, Wind wr, Wind wp){
    
	tiles= TileRules.sort_tiles(hand);
	this.calls=calls;
	this.wp=wp;
	this.wr=wr;
    
	call_pos(); //Discards any imposible yaku
	get_posible_yakumans_and_tips();
      
  }
  
  private string[] tips;
  public string[] gettips(){  return tips;  }
  
  private void call_pos(){
      
   if(calls.size>0){
	    pos_pinfu=false;
	    pos_peikou=false;
	    pos_toitsu=false;
	    pos_ryan_peikou=false;
	    pos_nagashi_mangan=false;
	    pos_kokushi_muso=false;
	    pos_chuuren_poto=false;
	    pos_suu_ankou=false;
	}
	
	
	foreach (RoundStateCall call in calls){
	  
	    if(call.tiles[0].is_suit_tile()){
	       string s =call.tiles[0].tile_type.to_string();
		if("MAN" in s) num_man++;
		else if("SOU" in s) num_sou++;
		else if("PIN" in s) num_pin++;
	    }
	    
            if (call.call_type == RoundStateCall.CallType.PON){
	      num_pon++;
	      if(call.tiles[0].is_honor_tile()){
		  num_honors++;
		
		
	       if(call.tiles[0].is_dragon_tile())
		   num_dragons++;
		  
		if(call.tiles[0].is_wind_tile())
		  num_winds++;
		    
	      }
	      
	     else if(call.tiles[0].is_terminal_tile())
		  num_terminals++;
	      
	     else  num_simple++;
	       	      
	    }
	    
	    if (call.call_type == RoundStateCall.CallType.CHII){
	      num_chii++;
	      if(call.tiles[0].is_terminal_tile() || call.tiles[2].is_terminal_tile())
		  num_term_and_simple++;
	      else num_simple++;
	      
	    }
	    if(pos_ryuu_iisou){
	      foreach(Tile tile in call.tiles){
		  if (tile.tile_type != TileType.SOU2 &&
			  tile.tile_type != TileType.SOU3 &&
			  tile.tile_type != TileType.SOU4 &&
			  tile.tile_type != TileType.SOU6 &&
			  tile.tile_type != TileType.SOU8 &&
			  tile.tile_type != TileType.HATSU)
		      { pos_ryuu_iisou=false;}
		}
	    }
	}
	
	if((num_man>0 && num_pin>0)||
	    (num_sou>0 && num_pin>0)||
	    (num_man>0 && num_sou>0)) pos_hon_itsu=false;
	
	
	
	if(num_pon>1){
	  pos_itsu= false; 
	  pos_doujun=false;
	  pos_itsu=false;
	  pos_ankou=false;
	}
	
	if(num_chii>0){
	  pos_hon_ron_tou=false;
	  pos_ron_tou=false;
	  pos_tsuu_iisou=false;
	  pos_dai_suushii=false;  
	  pos_toitoi=false;
	
	  if(num_chii>1){ 
	    pos_dokou=false;
	    pos_ankou=false;   
	    	
	    pos_dai_sangen=false;
	    pos_shu_suushii=false;
	
	  }
	 }
	
	if(num_terminals>0) {
	  pos_tanyao=false;
	  pos_ryuu_iisou=false;
	  pos_tsuu_iisou=false;
	
	  if(num_terminals>1){
	    pos_ankou=false;
	    pos_dai_sangen=false;
	    pos_shu_suushii=false; 
	    pos_dai_suushii=false;
	  }
	 }	
	
	 if(num_simple>0){
	   pos_chanta=false;
	   pos_ron_tou=false;
	   pos_junchan_taiyao=false;
	   pos_ron_tou=false;
	   pos_tsuu_iisou=false;
	   pos_dai_suushii=false;
	   if(num_simple>1){
	     pos_dai_sangen=false;
	     pos_shu_suushii=false;
	   }
	 }

	 if(num_honors>0){
	   pos_tanyao=false;
	   pos_junchan_taiyao=false;
	   pos_chin_itsu=false;
	   pos_ron_tou=false;
	       
	   if(num_dragons>0){
	     pos_dai_suushii=false;
	 
	    }
	    if(num_winds>0){
	    pos_ryuu_iisou=false;
	    }
	    
	   if(num_honors>1){
	     pos_itsu=false;
	     pos_dokou=false;
	     pos_ankou=false;
	     
	    if(num_dragons>1){
	     pos_shu_suushii=false;
	     pos_ryuu_iisou=false;
	 
	    }
	    if(num_winds>1){     
	     pos_dai_sangen=false;
	    }
	  } 
	 }
	 
	 if(num_term_and_simple>0){
	   if(num_term_and_simple>1){
	     pos_chin_itsu=false;
	   }
	   pos_tanyao=false;	   
	   pos_hon_ron_tou=false;
	   pos_junchan_taiyao=false;
	   pos_ryuu_iisou=false;
	   pos_chin_itsu=false;
	   pos_tsuu_iisou=false;
	   pos_dai_sangen=false;
	   pos_dai_suushii=false;
	 }
	    
    
 
 }

  private void get_posible_yakumans_and_tips(){
    foreach(Tile t in tiles){
     if(count(t)>=2)  o_num_pon++;
     if(has_neighbours(t)) o_num_chii+=2;
     if(has_second_neighbours(t)) o_num_chii++;
     if(t.is_honor_tile())o_num_honors++;
     if(t.is_suit_tile() && !t.is_terminal_tile()) o_num_simple++;
     if(t.is_dragon_tile()) o_num_dragons++;
     if(t.is_wind_tile())o_num_winds++;
     if(t.is_terminal_tile()) o_num_terminals++;
     
     
     Tile ex1= new Tile(999, TileType.MAN1,false);
     Tile ex2= new Tile(998, TileType.SOU1 ,false);
     Tile ex3= new Tile(997, TileType.PIN1, false);
     if(t.is_same_sort(ex1))o_num_man++;
     else if(t.is_same_sort(ex2))o_num_sou++;
     else if(t.is_same_sort(ex3))o_num_pin++;
      
    }
    
    
    
    string p;
    string n;
    if(pos_tanyao){
      n= "1Tanyao";
      if(num_simple*3+o_num_simple>=6) p="G";
      else p= "B";
      tips+=(p+n);
    }
    if(pos_pinfu){
      n= "1Pinfu";
      if(num_chii>=8) p="G";
      else p= "B";
      tips+=(p+n);      
    }

    if(pos_peikou){
      n= "1Ii Peikou";
      p="B";
      tips+=(p+n);     
    }
    if(pos_doujun){
      n= "1San Shoku Doujun";
      p= "B";
      tips+=(p+n);      
    }
    if(pos_itsu){
      n= "1Itsu";
      if((num_pin*3+o_num_pin)>=6 ||
	  (num_man*3+o_num_man)>=6||
	  (num_chii*3+o_num_chii)>=6) p="G";
      else p= "B";
      tips+=(p+n);      
    }
    if(pos_chanta){
      n= "1Chanta";
      if(num_terminals*3+ num_term_and_simple*3 + num_honors*3 +o_num_terminals + o_num_honors>=8) p="G";
      else p= "B";
      tips+=(p+n);    
    }
    
      // 2 yaku hands
    if(pos_dokou){
      n= "2San Shoku Dokou";
      p= "B";
      tips+=(p+n);     
    }
    if(pos_ankou){
      n= "2San Ankou";
      if(o_num_pon>=4) p="G";
      else p= "B";
      tips+=(p+n);
      
    }
    if(pos_toitoi){
      n= "2Toi Toi Hou";
      if(o_num_pon+num_pon*3>=5)p="G";
      else p= "B";
      tips+=(p+n);
      
    }
    
    if(pos_hon_itsu){
      n= "2Hon Itsu";
      if((num_pin*3+o_num_pin +num_honors*3+o_num_honors)>=8 ||
	  (num_man*3+o_num_man+num_honors*3+o_num_honors)>=8||
	  (num_chii*3+o_num_chii+num_honors*3+o_num_honors)>=8) p="G";
      else p= "B";
      tips+=(p+n);
      
    }
    
    if(pos_hon_ron_tou){
      n= "2Hon Ron Tou";
      if((num_terminals*3+o_num_terminals+num_honors*3+o_num_honors)>=7) p="G";
      else p= "B";
      tips+=(p+n);      
    }
    
    if(pos_junchan_taiyao){
      n= "2Junchan Taiyao";
      if((num_terminals*3+o_num_terminals+num_honors*3+o_num_honors)>=7)p="G";
      else p= "B";
      tips+=(p+n);      
    }
      //3-5 yakus
      
    /*
    if(pos_chin_itsu){
       n= "2Chin Itsu";
      if(false)
      else p= "B";
      tips+=(p+n);     
    }
    if(pos_nagashi_mangan){
       n= "2Nagashi Mangan";
      if(false)
      else p= "B";
      tips+=(p+n);     
    }
    */
	
	
    
	tips+="-------";
	tips+="Y0Yakus avaliable:";
	int useless_tiles;
	int waiting_tiles;
	int useful_tiles;
	
		//Aditional
	{

        ArrayList<Tile> copy = new ArrayList<Tile>();
        foreach (Tile tile in tiles)
        {
            copy.add_all(tiles);
            copy.remove(tile);

            if (TileRules.in_tenpai(copy, calls))
                tips+= "Y1Discard the " + tile.to_string_eng() +" and  you'll be in tenpai";

            copy.clear();
        }
	
	bool use=false;
        foreach (Tile tile in tiles)
        {
	  if(tile.is_honor_tile()){
            if (tile.is_wind_tile())
            {
                if (!tile.is_wind(wp) && !tile.is_wind(wr)) use=true;
                    
                else if (count(tile) <= 1)
                    use=true;
            }
            if (tile.is_dragon_tile())
            {
                if(count(tile) <= 1)
                    use=true;
            }
           
	  }
	  	  
	   if(use){
	      tips+="B1The " + tile.to_string_eng() +" is unlikely to be useful";
	      use=false;
	    }
        }	
	
	  
	}
	
	  

	 // Yakuhai /Shou sangen / Dai Sangen
        if(pos_yakuhai){
	
        
                   // Shou sangen / Dai sangen
	   int dragon_pon=0;
	   int dragon_pair=0;
	   int dragon_alone=0;
	   bool windpair1=false;
	   bool windpair2=false;
	   bool yakuhai=false;
	    foreach(RoundStateCall call in calls){
		if(call.tiles[0].is_dragon_tile() || call.tiles[0].is_wind(wp) || call.tiles[0].is_wind(wr)){
		    if(call.tiles[0].is_dragon_tile()) dragon_pon++;
		    yakuhai=true;
		    
		}
	    }
	    
	    foreach(Tile t in tiles){
	      if(t.is_dragon_tile()|| t.is_wind(wp) || t.is_wind(wr)){
		    if(count(t)>= 3){
		      if(t.is_dragon_tile()) dragon_pon++;
		      yakuhai=true;
		      
		      
		    }
		
		  if(count(t)==2 && (t.is_wind(wp) )) windpair1=true;
		  if(count(t)==2 && t.is_wind(wr) ) windpair2=true;
		
		  if(t.is_dragon_tile()){
		    if(count(t)==2)dragon_pair++;
		    if(count(t)==1)dragon_alone++;
		  }
		 
	      }
	      
	      
	    }
	  
	  dragon_pon= dragon_pon/3;
	  dragon_pair= dragon_pair/2;
	  
	  if(windpair1)tips+="B1You are 1 tile away from Player Wind Yakuhai";
	  if(windpair1)tips+="B1You are 1 tile away from Round Wind Yakuhai";
	  
	  if(dragon_pair>=1)tips+="B1You are 1 tile away from Dragon Yakuhai";
	  else if(yakuhai) tips+="G1You have Yakuhai";
		 
	  if(pos_shou_sangen){
	    if(dragon_pon==2 && dragon_pair==1) tips+="G2You have Shou Sangen";
	    else if(dragon_pon==2 ||(dragon_pon==1 && dragon_pair==1)) tips+="B2You are close to Shou Sangen";    
	  }
	  
	  if(pos_dai_sangen){
	    if(dragon_pon==3) tips+="W3You have Dai Sangen";
	    else if(dragon_pon==2 && (dragon_pair==1 || dragon_alone==1)) tips+= "Y3You are close to Dai Sangen!";
	  }
	    
	    
        }

		// Chiitoitsu (7 pairs)
        if (pos_toitsu){ 
	    int pairs=0;
	    for (int i=0; i< tiles.size-1;i++){
	      if( tiles[i].tile_type==  tiles[i+1].tile_type){
		  pairs++;
		  i++;
	      }
	    }
	    if(pairs>4){
	      int o= ((14-pairs*2)/2);
	      string s= "W2You are "+o.to_string()+ " tile(s) away from the SEVEN PAIRS"; 
	      tips += s;
	   }
	}
	
	
	//(YAKUMAN CASES)
	
        // Kokushi musou (13 orphans)
        if (pos_kokushi_muso)
        {
            int useful=0;
	    int repeated=0;
            for (int i=0; i<tiles.size;i++){
	      if(tiles[i].is_terminal_tile()|
		tiles[i].is_honor_tile()){ useful++;
	      
		if(i+1<tiles.size){
		  if(tiles[i].tile_type==tiles[i+1].tile_type){
		    repeated++;
		  }
		} 
	      }
            }
           if(repeated>0) repeated--;
           useless_tiles= 14 -(useful-repeated);
           if(useless_tiles<5){
	      string s= "W3You are "+useless_tiles.to_string()+ " tile(s) away from the 13 ORPHANS!"; 
	      tips += s;
	   }
        }
        

	// Tsuu iisou (ALL HONORS)
        if(pos_tsuu_iisou){
	    bool two_in_row=false;
	    useless_tiles=0;
	    useful_tiles=0;
	    waiting_tiles=0;
            for (int i=0; i< tiles.size-1;i++)
            {
                if (! tiles[i].is_honor_tile())
                {	
		    useless_tiles++;
		    two_in_row=false;
                }
                
                else{
		  useful_tiles++;
		  if( tiles[i].tile_type== tiles[i+1].tile_type){
		      if(two_in_row){ 
			two_in_row=false;			 
			waiting_tiles-=1;
			i++;
		      }
		      else{
			two_in_row=true;
			waiting_tiles-=1;
		      }
		  }
		  else{ waiting_tiles+=2; 
		      two_in_row=false;}
		} 
            }
            
            if((num_honors*3 + useful_tiles) > 8 && waiting_tiles < 5){
	      string s= "W3You are close to ALL HONORS!"; 
	      tips += s;
	   }
        }
	
	
	
	// Ryuuiisou (ALL GREEN)
	
        if(pos_ryuu_iisou){
             useless_tiles=0;

            foreach (Tile tile in  tiles)
            {
                if (tile.tile_type != TileType.SOU2 &&
                    tile.tile_type != TileType.SOU3 &&
                    tile.tile_type != TileType.SOU4 &&
                    tile.tile_type != TileType.SOU6 &&
                    tile.tile_type != TileType.SOU8 &&
                    tile.tile_type != TileType.HATSU){   useless_tiles++;
                }
            }

            if (useless_tiles<5) tips+="W3You are close to Ryuu Iisou";
        }
	
	
	// Shou suushii / Dai suushii (Four Winds)
        if (pos_shu_suushii)
        {
          if(num_winds*3+o_num_winds>7)  tips+="W3You have a lot of winds, dare to try a Dai /Shu Suushii?";
        }
	
	// Chinroutou (ALL TERMINALS)
        if(pos_ron_tou){
	  if(num_terminals*3+o_num_terminals>7)  tips+="W3You have a lot of terminals, dare to try a Chin Rou Tou?";
        }

      

    }


    private int count(Tile tile)
    {
        int count = 0;
        foreach (Tile t in tiles)
            if (t.tile_type == tile.tile_type)
                count++;
        return count;
    }
    
    private bool has_neighbours(Tile tile)
    {
        if (!tile.is_suit_tile())
            return false;

        foreach (Tile t in tiles)
        {
            if (tile == t)
                continue;

            if (tile.is_neighbour(t))
                return true;
        }

        return false;
    }

    private bool has_second_neighbours(Tile tile)
    {
        if (!tile.is_suit_tile())
            return false;

        foreach (Tile t in tiles)
        {
            if (tile == t)
                continue;

            if (tile.is_second_neighbour(t))
                return true;
        }

        return false;
    }
    
 
}


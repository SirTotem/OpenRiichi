using Gee;


public class QuickGuide : View2D
{
  private RectangleControl RedBackground;
  private MenuTextButton Tips_button;
  private LabelControl[]? Tips;
  
  private RectangleControl RedBackground2;
  private MenuTextButton wiki_button;
  private int current_layer;
  private ImageControl[] wikilayers;
  
  private GameMenuButton next_button;
  private GameMenuButton prev_button;
  
  
   public override void added()
    {
	
	 RedBackground = new RectangleControl();
	 add_child(RedBackground);	
	 RedBackground.color= Color(1,0,0,0.1f);
	 RedBackground.size= Size2(500,700);
	 RedBackground.position = Vec2(-550, 50);  //Com mes gran, més amunt a la dreta
	 RedBackground.visible = false;	
	
	 Tips_button = new MenuTextButton("MenuButtonSmall", "Tips (Alpha)");	
	 add_child(Tips_button);
         Tips_button.enabled = true;
         Tips_button.inner_anchor = Vec2(0.5f, 0);
         Tips_button.outer_anchor = Vec2(0.5f, 0);
         Tips_button.font_size = 24;
	 
	 Tips_button.position= Vec2(-690,20);	 
	 Tips_button.clicked.connect(press_tips);
	 
	  ///Wiki
	    
	 RedBackground2 = new RectangleControl();
	 add_child(RedBackground2);	
	 RedBackground2.color= Color(1,0,0,0.1f);
	 RedBackground2.size= Size2(475,650);
	 RedBackground2.position = Vec2(550, 50); 
	 RedBackground2.visible = false;	
	
	 wiki_button = new MenuTextButton("MenuButtonSmall", "Wiki");	
	 add_child(wiki_button);
         wiki_button.enabled = true;
         wiki_button.inner_anchor = Vec2(0.5f, 0);
         wiki_button.outer_anchor = Vec2(0.5f, 0);
         wiki_button.font_size = 24;
	 
	 wiki_button.position= Vec2(690,20);	 
	 wiki_button.clicked.connect(press_wiki); 
	 
	 prev_button = new GameMenuButton("Prev");
         next_button = new GameMenuButton("Next");
	 
	 add_child(prev_button);
	 prev_button.inner_anchor = Vec2(0.5f, 0);
	 prev_button.outer_anchor = Vec2(0.5f, 0);
	 prev_button.selectable = true;
	 prev_button.clicked.connect(prev_layer);
	 prev_button.position = Vec2(510,80);
	 prev_button.enabled = true;
	 prev_button.visible=false;
	  
	 add_child(next_button);
	 next_button.inner_anchor = Vec2(0.5f, 0);
	 next_button.outer_anchor = Vec2(0.5f, 0);
	 next_button.selectable = true;
	 next_button.clicked.connect(next_layer);
	 next_button.position = Vec2(650,80);
	 next_button.enabled = true;
	 next_button.visible= false;
	 
	 wikilayers= new ImageControl[4];
	 current_layer=0;	 
	 
	 wikilayers[0] = new ImageControl("Wiki/basics-sheet-wb");
	 wikilayers[1] = new ImageControl("Wiki/layer_yaku_1");
	 wikilayers[2] = new ImageControl("Wiki/layer_yaku_2");
	 wikilayers[3] = new ImageControl("Wiki/layer_yakuman");
	 
	 
	 for(int i=0;i< 4; i++){
	    
	    add_child(wikilayers[i]);
	    wikilayers[i].size = Size2(450,600);
	    wikilayers[i].resize_style = ResizeStyle.ABSOLUTE;
	    
	    wikilayers[i].position= Vec2(550,50);
	    wikilayers[i].visible= false;
	 }
	 
    }
    
    
      private void press_wiki(){
	RedBackground2.visible= !RedBackground2.visible;
	prev_button.visible=!prev_button.visible;
	next_button.visible=!next_button.visible;
	wikilayers[current_layer].visible= !wikilayers[current_layer].visible;
    }
      private void change_layer_wiki(int layer){
	RedBackground2.visible=true;
	prev_button.visible=true;
	next_button.visible=true;
	
	wikilayers[current_layer].visible= false;
	wikilayers[layer].visible= true;
	current_layer =layer;		
      }
      
      
    private void next_layer()
    {
        int layer = current_layer+1;
        if(layer==4) layer=0;
	change_layer_wiki(layer);
    }

    private void prev_layer()
    {
         int layer = current_layer-1;
        if(layer==-1) layer=3;
	change_layer_wiki(layer);
    }
    
    private void change_to1(){	change_layer_wiki(1); }
    private void change_to2(){	change_layer_wiki(2); }
    private void change_to3(){	change_layer_wiki(3); }
    private void change_to0(){	change_layer_wiki(0); }
    
    
    private void press_tips(){
        RedBackground.visible= !RedBackground.visible;
	foreach (LabelControl Tip in Tips){
	  Tip.visible =!Tip.visible;
	  Tip.selectable =!Tip.selectable;
	}
    }
    
    
    public void add_tips(string[] ntips){
	for (int i=0;i<ntips.length; i++){
	    if(ntips[i]!="-------"){
		
	      LabelControl t= new LabelControl();
	      add_child(t);
	      t.position = Vec2(-550, i*35 + 170);  //Com mes gran, més amunt a la dreta
	      t.font_size = 30;
	      t.size = Size2(450,35);
	      t.inner_anchor = Vec2(0.5f, 0);
	      t.outer_anchor = Vec2(0.5f, 0);
	      if( ntips[i][1].digit_value()==1) t.clicked.connect(change_to1);
	      else if( ntips[i][1].digit_value()==2) t.clicked.connect(change_to2);
	      else if( ntips[i][1].digit_value()==3) t.clicked.connect(change_to3);
	      else if( ntips[i][1].digit_value()==0) t.clicked.connect(change_to0);
	      t.text = ntips[i][2:ntips[i].length];
	      if (ntips[i][0]=='W') t.color = Color.white();
	      else if (ntips[i][0]=='Y') t.color = Color.black();
	      else if (ntips[i][0]=='B') t.color = Color.blue();
	      else if (ntips[i][0]=='G') t.color = Color.green();
	      
	      
	      t.visible = RedBackground.visible;
	      t.enabled = true;
	      t.selectable = RedBackground.visible;
	      Tips += t;
	    }
	  }

    }
    
     
     public void delete_tips(){
       for (int i=0;i<Tips.length; i++){
	 remove_child(Tips[i]);
       }
	//add_tip("No tips right now");
       
     }
       
  

}
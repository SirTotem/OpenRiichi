public class Tile : Serializable
{
    public Tile(int ID, TileType type, bool dora)
    {
        this.ID = ID;
        tile_type = type;
        this.dora = dora;
    }

    public bool is_same_sort(Tile other)
    {
        if (tile_type >= TileType.MAN1 && tile_type <= TileType.MAN9 &&
            other.tile_type >= TileType.MAN1 && other.tile_type <= TileType.MAN9)
            return true;
        if (tile_type >= TileType.PIN1 && tile_type <= TileType.PIN9 &&
            other.tile_type >= TileType.PIN1 && other.tile_type <= TileType.PIN9)
            return true;
        if (tile_type >= TileType.SOU1 && tile_type <= TileType.SOU9 &&
            other.tile_type >= TileType.SOU1 && other.tile_type <= TileType.SOU9)
            return true;

        return tile_type == other.tile_type;
    }

    public bool is_suit_tile()
    {
        if (tile_type >= TileType.MAN1 && tile_type <= TileType.MAN9)
            return true;
        if (tile_type >= TileType.PIN1 && tile_type <= TileType.PIN9)
            return true;
        if (tile_type >= TileType.SOU1 && tile_type <= TileType.SOU9)
            return true;

        return false;
    }

    public bool is_honor_tile()
    {
        if (tile_type == TileType.TON   ||
            tile_type == TileType.NAN   ||
            tile_type == TileType.SHAA  ||
            tile_type == TileType.PEI   ||
            tile_type == TileType.HAKU  ||
            tile_type == TileType.HATSU ||
            tile_type == TileType.CHUN)
            return true;

        return false;
    }

    public bool is_dragon_tile()
    {
        if (tile_type == TileType.HAKU  ||
            tile_type == TileType.HATSU ||
            tile_type == TileType.CHUN)
            return true;

        return false;
    }

    public bool is_wind_tile()
    {
        if (tile_type == TileType.TON  ||
            tile_type == TileType.NAN  ||
            tile_type == TileType.SHAA ||
            tile_type == TileType.PEI)
            return true;

        return false;
    }

    public bool is_terminal_tile()
    {
        if (tile_type == TileType.MAN1 ||
            tile_type == TileType.MAN9 ||
            tile_type == TileType.PIN1 ||
            tile_type == TileType.PIN9 ||
            tile_type == TileType.SOU1 ||
            tile_type == TileType.SOU9)
            return true;

        return false;
    }

    public bool is_wind(Wind wind)
    {
        return ((tile_type == TileType.TON  && wind == Wind.EAST)  ||
                (tile_type == TileType.NAN  && wind == Wind.SOUTH) ||
                (tile_type == TileType.SHAA && wind == Wind.WEST)  ||
                (tile_type == TileType.PEI  && wind == Wind.NORTH));
    }

    public int get_number_index()
    {
        if (tile_type >= TileType.MAN1 && tile_type <= TileType.MAN9)
            return tile_type - TileType.MAN1;
        if (tile_type >= TileType.PIN1 && tile_type <= TileType.PIN9)
            return tile_type - TileType.PIN1;
        if (tile_type >= TileType.SOU1 && tile_type <= TileType.SOU9)
            return tile_type - TileType.SOU1;

        return 0;
    }

    public bool is_neighbour(Tile tile)
    {
        if (!is_suit_tile() || !tile.is_suit_tile() || !is_same_sort(tile))
            return false;

        int type1 = (int)tile_type;
        int type2 = (int)tile.tile_type;

        return (type1 - type2).abs() == 1;
    }

    public bool is_second_neighbour(Tile tile)
    {
        if (!is_suit_tile() || !tile.is_suit_tile() || !is_same_sort(tile))
            return false;

        int type1 = (int)tile_type;
        int type2 = (int)tile.tile_type;

        return (type1 - type2).abs() == 2;
    }

    public TileType dora_indicator()
    {
        int type = (int)tile_type;

        if (type >= TileType.MAN1 && type <= TileType.MAN8)
            return (TileType)(type + 1);
        if (tile_type == TileType.MAN9)
            return TileType.MAN1;
        if (type >= TileType.PIN1 && type <= TileType.PIN8)
            return (TileType)(type + 1);
        if (tile_type == TileType.PIN9)
            return TileType.PIN1;
        if (type >= TileType.SOU1 && type <= TileType.SOU8)
            return (TileType)(type + 1);
        if (tile_type == TileType.SOU9)
            return TileType.SOU1;

        if (tile_type == TileType.TON)
            return TileType.NAN;
        if (tile_type == TileType.NAN)
            return TileType.SHAA;
        if (tile_type == TileType.SHAA)
            return TileType.PEI;
        if (tile_type == TileType.PEI)
            return TileType.TON;

        if (tile_type == TileType.HAKU)
            return TileType.HATSU;
        if (tile_type == TileType.HATSU)
            return TileType.CHUN;
        if (tile_type == TileType.CHUN)
            return TileType.HAKU;

        return TileType.BLANK;
    }

    public string to_string()
    {
        return "(" + ID.to_string() + ") " + tile_type.to_string() + (dora ? " dora" : " not dora");
    }
    
    public string to_string_eng()
    {
      string s="";
      switch(tile_type){
	  case TileType.BLANK: s="Unknown"; break;
	  case TileType.MAN1: s="Characters 1"; break;
	  case TileType.MAN2: s="Characters 2"; break;
	  case TileType.MAN3:	s="Characters 3"; break;
	  case TileType.MAN4: s="Characters 4"; break;
	  case TileType.MAN5: s="Characters 5"; break;
	  case TileType.MAN6: s="Characters 6";  break;
	  case TileType.MAN7: s="Characters 7"; break;
	  case TileType.MAN8: s="Characters 8"; break;
	  case TileType.MAN9: s="Characters 9"; break;
	  case TileType.PIN1: s="Dot 1"; break;
	  case TileType.PIN2: s="Dot 2"; break;
	  case TileType.PIN3: s="Dot 3"; break;
	  case TileType.PIN4: s="Dot 4"; break;
	  case TileType.PIN5: s="Dot 5"; break;
	  case TileType.PIN6: s="Dot 6"; break;
	  case TileType.PIN7: s="Dot 7"; break;
	  case TileType.PIN8: s="Dot 8"; break;
	  case TileType.PIN9: s="Dot 9"; break;
	  case TileType.SOU1: s="Bamboo 1"; break;
	  case TileType.SOU2: s="Bamboo 2"; break;
	  case TileType.SOU3: s="Bamboo 3"; break;
	  case TileType.SOU4: s="Bamboo 4"; break;
	  case TileType.SOU5: s="Bamboo 5"; break;
	  case TileType.SOU6: s="Bamboo 6"; break;
	  case TileType.SOU7: s="Bamboo 7"; break;
	  case TileType.SOU8: s="Bamboo 8"; break;
	  case TileType.SOU9: s="Bamboo 9"; break;
	  case TileType.TON: s="East Wind"; break;
	  case TileType.NAN: s="South Wind"; break;
	  case TileType.SHAA: s="West Wind"; break;
	  case TileType.PEI: s="North Wind"; break;
	  case TileType.HAKU: s="White Dragon"; break;
	  case TileType.HATSU: s="Green Dragon"; break;
	  case TileType.CHUN: s="Red Dragon"; break;
      }
        return s;
    }

    public int ID { get; set; }
    public TileType tile_type { get; set; }
    public bool dora { get; set; }

    /*public TileSuit tile_sort
    {
        get
        {
            if (tile_type == TileType.BLANK)
                return TileSuit.BLANK;

            if (tile_type >= TileType.MAN1 && tile_type <= TileType.MAN9)
                return TileSuit.MAN;
            if (tile_type >= TileType.PIN1 && tile_type <= TileType.PIN9)
                return TileSuit.PIN;
            if (tile_type >= TileType.SOU1 && tile_type <= TileType.SOU9)
                return TileSuit.SOU;

            return TileSuit.DRAGON;
        }
    }*/
}

/*public enum TileSuit
{
    BLANK,
    MAN,
    PIN,
    SOU,
    WIND,
    DRAGON
}*/

public enum Wind
{
    EAST,
    SOUTH,
    WEST,
    NORTH
}

public static Wind NEXT_WIND(Wind wind)
{
    switch (wind)
    {
    case Wind.EAST:
        return Wind.SOUTH;
    case Wind.SOUTH:
        return Wind.WEST;
    case Wind.WEST:
        return Wind.NORTH;
    case Wind.NORTH:
    default:
        return Wind.EAST;
    }
}

public static Wind PREVIOUS_WIND(Wind wind)
{
    switch (wind)
    {
    case Wind.EAST:
        return Wind.NORTH;
    case Wind.SOUTH:
        return Wind.EAST;
    case Wind.WEST:
        return Wind.SOUTH;
    case Wind.NORTH:
    default:
        return Wind.WEST;
    }
}

public static string WIND_TO_STRING(Wind wind)
{
    switch (wind)
    {
    case Wind.EAST:
    default:
        return "東";
    case Wind.SOUTH:
        return "南";
    case Wind.WEST:
        return "西";
    case Wind.NORTH:
        return "北";
    }
}

public enum TileType
{
    BLANK,
    MAN1,
    MAN2,
    MAN3,
    MAN4,
    MAN5,
    MAN6,
    MAN7,
    MAN8,
    MAN9,
    PIN1,
    PIN2,
    PIN3,
    PIN4,
    PIN5,
    PIN6,
    PIN7,
    PIN8,
    PIN9,
    SOU1,
    SOU2,
    SOU3,
    SOU4,
    SOU5,
    SOU6,
    SOU7,
    SOU8,
    SOU9,
    TON,
    NAN,
    SHAA,
    PEI,
    HAKU,
    HATSU,
    CHUN
}

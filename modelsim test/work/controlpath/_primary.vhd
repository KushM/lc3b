library verilog;
use verilog.vl_types.all;
entity controlpath is
    port(
        marE            : out    vl_logic;
        marmux          : out    vl_logic;
        pcmux           : out    vl_logic_vector(1 downto 0);
        pcE             : out    vl_logic;
        adjmux          : out    vl_logic;
        regmux          : out    vl_logic_vector(1 downto 0);
        mdrControl      : out    vl_logic;
        mdrmux          : out    vl_logic;
        mdrE            : out    vl_logic;
        opmux           : out    vl_logic_vector(1 downto 0);
        aluControl      : out    vl_logic_vector(2 downto 0);
        srmux           : out    vl_logic;
        drmux           : out    vl_logic;
        regWriteE       : out    vl_logic;
        nzpE            : out    vl_logic;
        irE             : out    vl_logic;
        lshift          : out    vl_logic;
        IR              : in     vl_logic_vector(15 downto 0);
        N               : in     vl_logic;
        Z               : in     vl_logic;
        P               : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        memWriteE       : out    vl_logic;
        state           : out    vl_logic_vector(4 downto 0)
    );
end controlpath;

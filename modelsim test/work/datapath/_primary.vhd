library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        marE            : in     vl_logic;
        mdrE            : in     vl_logic;
        nzpE            : in     vl_logic;
        regWriteE       : in     vl_logic;
        pcE             : in     vl_logic;
        irE             : in     vl_logic;
        memWriteE       : in     vl_logic;
        marmux          : in     vl_logic;
        srmux           : in     vl_logic;
        drmux           : in     vl_logic;
        regmux          : in     vl_logic_vector(1 downto 0);
        adjmux          : in     vl_logic;
        pcmux           : in     vl_logic_vector(1 downto 0);
        opmux           : in     vl_logic_vector(1 downto 0);
        mdrmux          : in     vl_logic;
        mdrControl      : in     vl_logic;
        lshift          : in     vl_logic;
        aluControl      : in     vl_logic_vector(2 downto 0);
        N               : out    vl_logic;
        Z               : out    vl_logic;
        P               : out    vl_logic;
        opcode          : out    vl_logic_vector(15 downto 0)
    );
end datapath;

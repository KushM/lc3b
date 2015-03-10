library verilog;
use verilog.vl_types.all;
entity memory is
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector(15 downto 0);
        dout            : out    vl_logic_vector(15 downto 0);
        din             : in     vl_logic_vector(15 downto 0);
        WE              : in     vl_logic;
        reset           : in     vl_logic;
        mdrControl      : in     vl_logic
    );
end memory;

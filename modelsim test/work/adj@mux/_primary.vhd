library verilog;
use verilog.vl_types.all;
entity adjMux is
    port(
        irOut           : in     vl_logic_vector(15 downto 0);
        adjmux          : in     vl_logic;
        adjmuxOut       : out    vl_logic_vector(15 downto 0)
    );
end adjMux;

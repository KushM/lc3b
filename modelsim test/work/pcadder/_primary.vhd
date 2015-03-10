library verilog;
use verilog.vl_types.all;
entity pcadder is
    port(
        pcOut           : in     vl_logic_vector(15 downto 0);
        adjmuxOut       : in     vl_logic_vector(15 downto 0);
        pcadderOut      : out    vl_logic_vector(15 downto 0)
    );
end pcadder;

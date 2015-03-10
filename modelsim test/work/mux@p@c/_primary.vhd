library verilog;
use verilog.vl_types.all;
entity muxPC is
    port(
        increasedPC     : in     vl_logic_vector(15 downto 0);
        aluOut          : in     vl_logic_vector(15 downto 0);
        adderPC         : in     vl_logic_vector(15 downto 0);
        pcmuxOut        : out    vl_logic_vector(15 downto 0);
        pcmux           : in     vl_logic_vector(1 downto 0)
    );
end muxPC;

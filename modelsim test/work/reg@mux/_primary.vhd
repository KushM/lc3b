library verilog;
use verilog.vl_types.all;
entity regMux is
    port(
        regmux          : in     vl_logic_vector(1 downto 0);
        mdrOut          : in     vl_logic_vector(15 downto 0);
        pcadderOut      : in     vl_logic_vector(15 downto 0);
        aluOut          : in     vl_logic_vector(15 downto 0);
        pcOut           : in     vl_logic_vector(15 downto 0);
        regmuxOut       : out    vl_logic_vector(15 downto 0)
    );
end regMux;

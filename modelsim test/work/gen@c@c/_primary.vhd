library verilog;
use verilog.vl_types.all;
entity genCC is
    port(
        aluOut          : in     vl_logic_vector(15 downto 0);
        nzp             : out    vl_logic_vector(2 downto 0)
    );
end genCC;

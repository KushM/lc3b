library verilog;
use verilog.vl_types.all;
entity mdr is
    port(
        mdre            : in     vl_logic;
        mdrControl      : in     vl_logic;
        din             : in     vl_logic_vector(15 downto 0);
        dout            : out    vl_logic_vector(15 downto 0)
    );
end mdr;

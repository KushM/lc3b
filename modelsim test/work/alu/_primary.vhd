library verilog;
use verilog.vl_types.all;
entity alu is
    generic(
        op_add          : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        op_and          : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        op_xor          : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        op_lsh          : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        op_rs0          : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        op_rss          : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        op_nopA         : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0);
        op_nopB         : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi1)
    );
    port(
        inputA          : in     vl_logic_vector(15 downto 0);
        inputB          : in     vl_logic_vector(15 downto 0);
        aluControl      : in     vl_logic_vector(2 downto 0);
        aluOut          : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of op_add : constant is 1;
    attribute mti_svvh_generic_type of op_and : constant is 1;
    attribute mti_svvh_generic_type of op_xor : constant is 1;
    attribute mti_svvh_generic_type of op_lsh : constant is 1;
    attribute mti_svvh_generic_type of op_rs0 : constant is 1;
    attribute mti_svvh_generic_type of op_rss : constant is 1;
    attribute mti_svvh_generic_type of op_nopA : constant is 1;
    attribute mti_svvh_generic_type of op_nopB : constant is 1;
end alu;

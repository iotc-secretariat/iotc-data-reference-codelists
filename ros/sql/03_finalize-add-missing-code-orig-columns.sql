-- There is still some null values on type_of_fate_code, since type_of_fate_id is null
-- ALTER TABLE ros_ll.ll_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_gn.gn_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_ps.ps_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_pl.pl_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_common.measured_lengths ALTER COLUMN  type_of_measurement_code SET NOT NULL;
ALTER TABLE ros_common.estimated_weights ALTER COLUMN  type_of_measurement_code SET NOT NULL;
-- alter table refs_admin.ports add constraint uk_ports_code unique (code);
-- delete from refs_admin.ports where id=8874;
-- delete from refs_admin.ports where id=8663;
-- delete from refs_admin.ports where id=7926;
-- delete from refs_admin.ports where id=7869;

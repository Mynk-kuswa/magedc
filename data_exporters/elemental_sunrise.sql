call idba.of_setTempTriggerOption('off');
insert into zip_master (zipid,city,state,createdby,createddt,changeby,changedt,srno,county,sync_zip_id,imsgo_device_no,country_code)
select 
    zip_master_all.zipid, 
    zip_master_all.city, 
    zip_master_all.state,
    'System',

    today(),
    'System',
    today(),
    cast(number(*) + (select max(cast(srno as int)) from zip_master) as int),

    null,
    null,
    null,
    null

from (select zip, city, state from dc_EXP_patient where zip is not null group by zip, city, state) Zips
join zip_master_all 
on Zips.zip = Zip_master_all.zipid
where  Zips.zip not in (select zipid from zip_master);
call idba.of_setTempTriggerOption('on');
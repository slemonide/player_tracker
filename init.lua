PLAYER_LOG_PATH = minetest.get_worldpath() .. "/player_log.csv"

function record_players()
    player_log = io.open(PLAYER_LOG_PATH, "a")
    for _, obj in pairs(minetest.get_connected_players()) do
        data = {}
        --table.insert(data, (minetest.get_us_time() - init_time)/1000000.0)
        table.insert(data, os.date())
        table.insert(data, obj:get_player_name())

        table.insert(data, obj:get_pos().x)
        table.insert(data, obj:get_pos().y)
        table.insert(data, obj:get_pos().z)

        table.insert(data, obj:get_player_velocity().x)
        table.insert(data, obj:get_player_velocity().y)
        table.insert(data, obj:get_player_velocity().z)

        table.insert(data, obj:get_look_dir().x)
        table.insert(data, obj:get_look_dir().y)
        table.insert(data, obj:get_look_dir().z)

        table.insert(data, obj:get_breath())
        table.insert(data, obj:get_hp())
        
        table.insert(data, obj:get_wielded_item():get_name())
        table.insert(data, obj:get_wielded_item():get_count())
        table.insert(data, obj:get_wielded_item():get_wear())

        player_log:write(table.concat(data, ",") .. "\n")
    end
    io.close(player_log)
    minetest.after(1.0, record_players)
end

function init_file()
    player_log = io.open(PLAYER_LOG_PATH, "a")
    player_log:write("date, name," ..
          "x, y, z," ..
          "vx, vy, vz," ..
          "look_x, look_y, look_z," ..
          "breath, hp," ..
          "wielded_item, wielded_item_count, wielded_item_wear\n")
    io.close(player_log)
end

minetest.after(0, init_file)
minetest.after(1.0, record_players)

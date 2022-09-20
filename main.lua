require("_table")
require("utils")

t = Table:new({title="Sooongs", h_char='~', v_char='|', head_h_char='='})
t:add_column({name="Title", align="left", max_size=120})
t:add_column({name="Singer", align="center"})
t:add_column({name="Duration", align="right", })

t:add_row("Hell On Earth", "VyOk", "2:32")
t:add_row("Part XI", "Prequell, Fyfe", "4:09")
t:add_row("Rise", "From Fall to Spring", "3:40")
t:add_row("They Don't Care About Us", "Matty Carter + Ariel", "3:18")
t:add_row("Animal", "Jim Yosef, RIELL", "2:52")
t:add_row("Talkin' About You", "Hollywood Undead", "5:00")
t:add_row("I Came to Party", "Hollywood Undead", "3:39")
t:add_row("The Black", "Asking Alexandria", "4:41")
t:add_row("The Tragedy", "Annisokay", "4:14")
t:add_row("NO TURNING BACK", "NEFFEX", "2:36")
t:add_row("Royal Beggars", "Architects", "4:01")
t:add_row("Architects are a British metalcore band from Brighton, East Sussex, formed in 2004 by twin brothers Dan and Tom Searle. The band now consists of Dan Searle on drums, Sam Carter on vocals, Alex Dean on bass, and Adam Christianson and Josh Middleton on guitars. They have been signed to Epitaph Records since 2013.", "Architects", "2:36")
t:add_row("Royal Beggars", "Strongly influenced by bands such as The Dillinger Escape Plan, the sound of their first three albums was coarse, chaotic, and rhythmically complex. In 2011, Architects went in a more melodic post-hardcore direction with The Here and Now, alienating some of their fanbase.", "4:01")

-- just print table
t:show_table()
-- print range of rows
t:show_table({show_title=true, start_row_n=10, end_row_n=13})
-- print one column
t:show_column("Title")
-- print one row
t:show_row(12)

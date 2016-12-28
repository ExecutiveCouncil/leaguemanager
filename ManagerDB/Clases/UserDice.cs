using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerDB.Clases
{
    public class UserDice
    {
        public int? id_die_type { get; set; }         
        public DateTime? spent_date { get; set; }
        public int? resources_gained { get; set; }
        public DateTime? rolled_date { get; set; }
        public string die_type_name { get; set; }         
        public int? total_faces { get; set; }         
        public string info_die { get; set; }        
        public int? die_face { get; set; }         
        public string action { get; set; }        
        public string info_face { get; set; }
        public int? cost_credits { get; set; }
        public int? sell_materials { get; set; }
        public int? sell_credits { get; set; }        
        public string img_Dice { get; set; }
        public string info { get; set; }  
    }
}
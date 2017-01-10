using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerDB.Clases
{
    public class UserDice
    {
        public string user_name { get; set; }  
        public int? id { get; set; }  
        public int? id_die_type { get; set; }         
        public DateTime? spent_date { get; set; }
        public int? resources_gained { get; set; }
        public DateTime? rolled_date { get; set; }
        public string die_type_name { get; set; }         
        public int? total_faces { get; set; }         
        public string info_die { get; set; }        
        public int? id_die_face { get; set; }         
        public string action { get; set; }        
        public string info_face { get; set; }
        public int? cost_credits { get; set; }
        public int? sell_materials { get; set; }
        public int? sell_credits { get; set; }        
        public string img_Dice { get; set; }
        public string info { get; set; }
        public int? die_face { get; set; }
        public int? id_user_league { get; set; }
        public int? round { get; set; }
        public int? cost { get; set; }
        public DateTime? admin_date { get; set; }
        public int? status { get; set; }
        public string user_avatar { get; set; }
        public int? creditos { get; set; }
        public int? materiales { get; set; }
        public string textoCreditos { get; set; }
        public string textoMateriales { get; set; }
        public int? id_user { get; set; }
    }
}
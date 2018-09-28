using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace DATA.EF
{
    [MetadataType(typeof(ProvinceListMetaData))]
    public partial class ProvinceList
    {

    }
    public class ProvinceListMetaData
    {

        public int ProvinceID { get; set; }

        [DisplayName("Provincial alias")]
        public string Alias { get; set; }


        public string Province { get; set; }

    }
}
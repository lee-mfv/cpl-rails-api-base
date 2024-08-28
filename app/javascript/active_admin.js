import './admin/jquery'
import 'jquery-ui/ui/widget'
import 'jquery-ui/ui/widgets/datepicker'
import 'jquery-ui/ui/widgets/mouse'
import 'jquery-ui/ui/widgets/sortable'
import 'jquery-ui/ui/widgets/tabs'
import 'jquery-ui/ui/widgets/dialog'
import 'jquery-ujs'
import '@activeadmin/activeadmin'
import 'arctic_admin'

$(document).ready(function() {
  // $('th.sortable').each(function(_i) {
  //   handleSort($(this));
  // });
  setTotalUser();

  // function handleSort(el) {
  //   if (el.hasClass('sorted-asc')) {
  //     el.removeClass('sorted-asc').addClass('sorted-desc');
  //   } else if (el.hasClass('sorted-desc')) {
  //     el.removeClass('sorted-desc').addClass('sorted-asc');
  //   }
  // }

  function setTotalUser() {
    total_el = $('#index_footer .pagination_information b')
    total = total_el.text().replace('all', '').trim()
    if (total > 1) {
      new_total = parseInt(total) + 1
      total_el.text('all ' + new_total)
    }
  }
});

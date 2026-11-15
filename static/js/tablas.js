document.addEventListener('DOMContentLoaded', () => {
  if (typeof DataTable === 'undefined') return;
  document.querySelectorAll('.tabla-datos').forEach(tabla => new DataTable(tabla, {
    pageLength: 10, order: [], columnDefs: [{ targets: 'sin-orden', orderable: false }],
    language: {
      search: 'Buscar:', lengthMenu: 'Mostrar _MENU_ registros',
      info: 'Mostrando _START_ a _END_ de _TOTAL_ registros', infoEmpty: 'Sin registros',
      infoFiltered: '(filtrados de _MAX_ registros)', zeroRecords: 'No se encontraron coincidencias',
      emptyTable: 'Todavía no hay registros.', paginate: { first: 'Primera', last: 'Última', next: 'Siguiente', previous: 'Anterior' }
    }
  }));
});

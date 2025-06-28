function fn() {
  var uuid = java.util.UUID.randomUUID() + '';
  var email = 'usuario_' + uuid.substring(0, 8) + '@mail.com';
  var nome = 'Usuario_' + uuid.substring(0, 5);
  var senha = 'Password123';

  return {
    nome: nome,
    email: email,
    password: senha,
    administrador: "true"
  }
}
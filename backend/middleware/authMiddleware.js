const userId = req.header('user_id');
if (!userId) {
  return res.status(401).json({ message: 'Acceso no autorizado, se requiere user_id' });
}

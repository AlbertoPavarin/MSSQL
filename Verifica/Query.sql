USE sandwiches;

SELECT COUNT(o.user) , o.`user`, u.name, u.surname 
from `order` o
LEFT JOIN `user` u ON u.id = o.`user` 
GROUP BY (`user`)
ORDER BY `user` ASC;

-- Quante volte sono state ordinati i prodotti
SELECT COUNT(p.id), p.id, p.name, p.description 
FROM product_order po 
LEFT JOIN product p ON po.product = p.id
WHERE 1=1
GROUP BY (p.id)
ORDER BY p.id ASC;

-- Prodotto preferito degli utenti
SELECT u.name, u.surname, p.name, p.price, p.description 
FROM favourite f 
LEFT JOIN `user` u ON u.id = f.`user` 
LEFT JOIN product p ON p.id = f.product 
WHERE 1=1
ORDER BY f.`user` ASC;

-- Numero ordini della classe
SELECT COUNT(o.id), c.`year`, c.`section` 
FROM `order` o 
LEFT JOIN user_class uc ON uc.`user` = o.`user` 
LEFT JOIN class c ON c.id = uc.class 
GROUP BY (c.id);

SELECT DISTINCT(i.description), i.quantity
FROM product p 
LEFT JOIN product_ingredient pi2 on pi2.product = p.id
LEFT JOIN ingredient i ON pi2.ingredient = i.id
ORDER BY i.quantity DESC;

SELECT i.name, i.quantity 
FROM ingredient i 
ORDER BY i.quantity DESC;

-- Prodotto con più calorie
SELECT p.name, nv.kcal 
FROM product p 
LEFT JOIN nutritional_value nv ON p.nutritional_value = nv.id
ORDER BY nv.kcal DESC;

SELECT p.name, p.description, u.name, u.surname
FROM product_order po  
LEFT JOIN product p ON p.id = po.product
LEFT JOIN `order` o ON po.`order` = o.id
LEFT JOIN `user` u ON u.id = o.`user` 
ORDER BY u.id DESC;

-- Numero ordini fatti dagli studenti
SELECT u.name, u.surname, COUNT(o.id) 
FROM `order` o
LEFT JOIN `user` u ON u.id = o.`user` 
WHERE 1=1
GROUP BY (u.id)
ORDER BY u.id  ASC;

SELECT COUNT(i.name) ,i.name
FROM product p 
LEFT JOIN product_ingredient pi2 ON pi2.product = p.id 
LEFT JOIN ingredient i ON i.id = pi2.ingredient 
WHERE pi2.ingredient != ""
GROUP BY (i.id)
ORDER BY i.id DESC;


SELECT (ingredient_count), product_name FROM(
	SELECT COUNT(*) AS ingredient_count, p.name AS product_name
	FROM product_ingredient pi2
	LEFT JOIN product p ON p.id = pi2.product 
	GROUP BY p.id
) sium;


-- Prodotti nel carrello
SELECT u.name, u.surname, p.name, c.quantity , p.price * c.quantity
FROM cart c
LEFT JOIN `user` u ON u.id = c.`user` 
LEFT JOIN product p ON c.product = p.id
ORDER BY u.id;

-- product con allergia glutine
SELECT p.name 
FROM product_allergen pa 
LEFT JOIN product p ON pa.product = p.id 
LEFT JOIN allergen a ON a.id = pa.allergen
WHERE a.name = "Glutine"
ORDER BY p.id;

-- Get tabella nutrizionale e allergeni di un prodotto
SELECT p.name, nv.kcal, a.name
FROM product p 
LEFT JOIN product_allergen pa ON pa.product = p.id 
LEFT JOIN allergen a ON pa.allergen = a.id 
LEFT JOIN nutritional_value nv ON nv.id = p.nutritional_value
ORDER BY p.id;

-- Somma tutti i prodotti che hai nel carrello
SELECT u.name, u.surname, sum(c.quantity)
FROM cart c
LEFT JOIN `user` u ON u.id = c.`user` 
LEFT JOIN product p ON c.product = p.id
GROUP BY u.id 
ORDER BY u.id;

-- somma prodotti magazzino
SELECT p.name, p.quantity
FROM product p 
ORDER BY p.quantity desc;

-- stampa numero ordini che ha fatto ogni utente
SELECT u.name, u.surname, COUNT(o.id)
FROM `order` o 
LEFT JOIN `user` u ON u.id = o.`user`
GROUP BY u.id 
ORDER BY u.id;

-- panini ordinati nella seconda ricreazione nella settore A (11:25:00) (Settore A itis)
SELECT p2.name
FROM `order` o 
LEFT JOIN break b ON b.id = o.break 
LEFT JOIN pickup p ON p.id = o.pickup
LEFT JOIN product_order po ON po.`order` = o.id 
LEFT JOIN product p2 ON p2.id = po.product 
WHERE b.`time` = '11:25:00' AND p.name  = 'Settore A itis';

-- prodotti ordinati dagli utenti + calcolo prezzo totale
SELECT u.name, u.surname, SUM(p.id), SUM(p.id * p.price)
FROM `order` o 
INNER JOIN `user` u ON u.id = o.`user` 
INNER JOIN product_order po ON po.`order` = o.id 
INNER JOIN product p ON p.id = po.product 
GROUP BY o.id 
ORDER BY u.id;

-- prodotto preferito di una classe
SELECT c.`year`, c.`section`, p.name 
FROM favourite f 
INNER JOIN `user` u ON u.id = f.`user` 
INNER JOIN user_class uc ON uc.`user` = u.id 
INNER JOIN class c ON c.id = uc.class 
INNER JOIN product p ON p.id = f.product 
ORDER BY u.id; 

-- prodotti ordinati da una classe
SELECT c.`year`, c.`section` , p.name 
FROM `order` o 
INNER JOIN `user` u ON u.id = o.`user` 
INNER JOIN product_order po ON o.id = po.`order` 
INNER JOIN product p ON p.id = po.product 
INNER JOIN user_class uc ON uc.`user` = u.id 
INNER JOIN class c ON c.id = uc.class
ORDER BY c.id ;

-- panini più venduti da una classe
SELECT c.`year`, c.`section` , p.name
FROM `order` o 
INNER JOIN `user` u ON u.id = o.`user` 
INNER JOIN product_order po ON o.id = po.`order` 
INNER JOIN product p ON p.id = po.product 
INNER JOIN user_class uc ON uc.`user` = u.id 
INNER JOIN class c ON c.id = uc.class
ORDER BY c.id;

-- prodotti venduti con quantità ad una classe
SELECT c.`year`, c.`section`, p.name, po.quantity 
FROM `order` o 
INNER JOIN `user` u ON u.id = o.`user` 
INNER JOIN user_class uc ON uc.`user` = u.id 
INNER JOIN class c ON c.id = uc.class 
INNER JOIN product_order po ON po.`order` = o.id 
INNER JOIN product p ON p.id = po.product 
ORDER BY c.id;

-- prodotti ordinati dalla 5F con ingrediente formaggio
SELECT c.`year`, c.`section` , p.name 
FROM `order` o 
INNER JOIN `user` u ON u.id = o.`user` 
INNER JOIN product_order po ON o.id = po.`order` 
INNER JOIN product p ON p.id = po.product 
INNER JOIN user_class uc ON uc.`user` = u.id 
INNER JOIN class c ON c.id = uc.class
INNER JOIN product_ingredient pi2 ON pi2.product = p.id 
INNER JOIN ingredient i ON pi2.ingredient  = i.id
WHERE i.name = "Pane" AND c.`year` = 5 AND c.`section` = "F"
ORDER BY c.id;

-- Numero di volte che un prodotto è stato ordinato
SELECT p.name, COUNT(o.id)
FROM `order` o 
INNER JOIN product_order po ON po.`order` = o.id 
INNER JOIN product p ON p.id = po.product 
GROUP BY p.id
ORDER BY COUNT(o.id);

-- Numero di volte che un ingrediente è stato ordinato
SELECT i.name, COUNT(i.id) 
FROM `order` o 
INNER JOIN product_order po ON po.`order` = o.id 
INNER JOIN product p ON p.id = po.product
INNER JOIN product_ingredient pi2 ON pi2.product = p.id 
INNER JOIN ingredient i ON i.id = pi2.ingredient 
GROUP BY i.id 
ORDER BY COUNT(i.id);

-- Tutte le offerte 
SELECT *
FROM offer o;

-- Prodotti in offerta
SELECT p.name
FROM product_offer po 
INNER JOIN product p ON p.id = po.product 
INNER JOIN offer o on o.id = po.offer
ORDER BY p.id;

-- Ordini degli studenti annullati
SELECT u.name, u.surname , o.id, s.description 
FROM `order` o 
INNER JOIN `user` u ON u.id = o.`user` 
INNER JOIN status s ON s.id = o.status 
WHERE s.description = "Annullato"
ORDER BY o.id;

-- Prodotto più venduto in assoluto
SELECT p.name, SUM(po.quantity) 
FROM `order` o 
INNER JOIN product_order po ON po.`order` = o.id 
INNER JOIN product p ON p.id = po.product
GROUP BY p.id 
ORDER BY p.id;

-- prodotto singolo preferito di una classe
SELECT c.`year`, c.`section`, p.name
	FROM favourite f 
	INNER JOIN `user` u ON u.id = f.`user` 
	INNER JOIN user_class uc ON uc.`user` = u.id 
	INNER JOIN class c ON c.id = uc.class 
	INNER JOIN product p ON p.id = f.product 
	GROUP BY c.id, p.id 
	ORDER BY c.id;
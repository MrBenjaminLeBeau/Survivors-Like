extends Button

@onready var player = get_tree().get_first_node_in_group("player")

@onready var name_label = $NameLabel
@onready var description_label = $DescriptionLabel
@onready var level_label = $LevelLabel
@onready var item_icon = $Picture/ItemIcon

signal selected_upgrade(upgrade)
var item = null


func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	
	if item == null:
		item = "food"
	
	name_label.text = UpgradeDataBase.UPGRADES[item]["display_name"]
	description_label.text = UpgradeDataBase.UPGRADES[item]["description"]
	level_label.text = UpgradeDataBase.UPGRADES[item]["level"]
	item_icon = load(UpgradeDataBase.UPGRADES[item]["icon"])


func _on_pressed():
	emit_signal("selected_upgrade", item)
